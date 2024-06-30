import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gieco_west/DataLayer/Model/failures_entity.dart';
import 'package:gieco_west/DataLayer/Model/my_report.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:gieco_west/DataLayer/Model/success.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/DataLayer/SharedPreferences/shared_preferences.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:provider/provider.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static FirebaseUtils? _firebaseUtils;

  static FirebaseUtils getInstance() {
    _firebaseUtils ??= FirebaseUtils._();
    return _firebaseUtils!;
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFirestore(snapshot.data()),
            toFirestore: (user, _) => user.toFirestore());
  }

  Future<Either<Failures, Success>> signInFirebase(
      String emailAddress, String password, BuildContext context) async {
    if (await _checkConnectivity()) {
      try {
        // sign in
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);

        // read user data
        var user = await readUserFromFirestore(credential.user!.uid);

        // save user data
        await SharedPreference.saveUserData(userDto: user);

        // update user data
        var provider = Provider.of<UserProvider>(context, listen: false);
        provider.updateUser(newUser: user);

        return Right(Success());
      } on FirebaseAuthException catch (e) {
        return Left(Failures(errorMessage: e.code));
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> signUpFirebase(
      MyUser user, BuildContext context) async {
    if (await _checkConnectivity()) {
      try {
        // sign in
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: user.email!, password: user.password!);

        user.id = credential.user!.uid;

        // save user data to firestore

        addUserToFirestore(user);

        // save user data
        await SharedPreference.saveUserData(userDto: user);

        // update user data
        var provider = Provider.of<UserProvider>(context, listen: false);
        provider.updateUser(newUser: user);

        return Right(Success());
      } on FirebaseAuthException catch (e) {
        return Left(Failures(errorMessage: e.code));
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> addUserToFirestore(MyUser user) async {
    if (await _checkConnectivity()) {
      try {
        DocumentReference<MyUser> docRef = getUsersCollection().doc(user.id!);
        docRef.set(user).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            Left(Failures(errorMessage: "time out , please try again later"));
          },
        );
        return right(Success());
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<MyUser> readUserFromFirestore(String uid) async {
    var querySnapshot = await getUsersCollection().doc(uid).get();
    return querySnapshot.data()!;
  }

  static CollectionReference<TripReport> getTripReportCollection(String date) {
    String collectionName = "Reports";

    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(date.toString())
        .collection(TripReport.collectionName)
        .withConverter<TripReport>(
            fromFirestore: (snapshot, options) =>
                TripReport.fromFirestore(snapshot.data()),
            toFirestore: (reportModel, _) => reportModel.toFirestore());
  }

  static CollectionReference<ShiftReport> getShiftReportCollection(
      String date) {
    String collectionName = "Reports";

    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(date.toString())
        .collection(ShiftReport.collectionName)
        .withConverter<ShiftReport>(
            fromFirestore: (snapshot, options) =>
                ShiftReport.fromFirestore(snapshot.data()),
            toFirestore: (reportModel, _) => reportModel.toFirestore());
  }

  // add task object to firestore
  Future<Either<Failures, Success>> addTripReportToFirestore(
      TripReport report) async {
    if (await _checkConnectivity()) {
      try {
        // String? docId = report.generalReportData?.locoNo;
        CollectionReference<TripReport> reportCollection =
            getTripReportCollection(report
                .generalReportData!.locoDate!.millisecondsSinceEpoch
                .toString());
        DocumentReference<TripReport> docRef = reportCollection.doc();
        docRef.set(report).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            Left(Failures(errorMessage: "time out , please try again later"));
          },
        );
        return right(Success());
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> addShiftReportToFirestore(
      ShiftReport report) async {
    if (await _checkConnectivity()) {
      try {
        // String? docId = report.generalReportData?.locoNo;
        CollectionReference<ShiftReport> reportCollection =
            getShiftReportCollection(report
                .generalReportData!.locoDate!.millisecondsSinceEpoch
                .toString());
        DocumentReference<ShiftReport> docRef = reportCollection.doc();
        docRef.set(report).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            Left(Failures(errorMessage: "time out , please try again later"));
          },
        );
        return right(Success());
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.bluetooth) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<Failures, Success>> uploadImage(
      File pickedImageFile, String title) async {
    if (await _checkConnectivity()) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child('$title.jpg');
        await storageRef.putFile(pickedImageFile);
        return Right(Success());
      } on Exception catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, String?>> getImageUrl(String title) async {
    if (await _checkConnectivity()) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child('$title.jpg');
        final String imageUrl = await storageRef.getDownloadURL();
        return right(imageUrl);
      } on Exception catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> createTripReportFirestore(
      String dateTime) async {
    if (await _checkConnectivity()) {
      try {
        var querySnapshot = await getTripReportCollection(dateTime).get();
        var data = querySnapshot.docs.map((doc) => doc.data()).toList();
        if (data.isEmpty) {
          return Left(Failures(errorMessage: "عفواً لا توجد بيانات للتقارير"));
        }

        var either = await createTripReportExcel(data, dateTime);

        return either.fold(
          (l) {
            return Left(Failures(errorMessage: l.errorMessage));
          },
          (r) {
            return right(Success());
          },
        );
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> createShiftReportFirestore(
      String dateTime) async {
    if (await _checkConnectivity()) {
      try {
        var querySnapshot = await getShiftReportCollection(dateTime).get();
        var data = querySnapshot.docs.map((doc) => doc.data()).toList();
        if (data.isEmpty) {
          return Left(Failures(errorMessage: "عفواً لا توجد بيانات للتقارير"));
        }

        var either = await createShiftReportExcel(data, dateTime);

        return either.fold(
          (l) {
            return Left(Failures(errorMessage: l.errorMessage));
          },
          (r) {
            return right(Success());
          },
        );
      } catch (e) {
        return Left(Failures(errorMessage: e.toString()));
      }
    } else {
      return Left(Failures(errorMessage: "Network Error"));
    }
  }

  Future<Either<Failures, Success>> createShiftReportExcel(
      List<ShiftReport> data, String date) async {
    String dateString = MyFunctions.millisecondsToFormattedDate(date);
    var excel = Excel.createExcel();
    Sheet shiftReportSheet = excel['Sheet1'];
    excel.setDefaultSheet(shiftReportSheet.sheetName);

    // Add headers (assuming all documents have the same structure)
    int index = 0;
    Map<String, dynamic> firstDocument =
        data[index].toExcelSheet(data[index].toFirestore());
    int columnIndex = 0;
    for (var key in firstDocument.keys) {
      shiftReportSheet
          .cell(
              CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: 0))
          .value = key;

      columnIndex++;
    }
    // Add data
    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      Map<String, dynamic> document =
          data[rowIndex].toExcelSheet(data[rowIndex].toFirestore());
      int columnIndex = 0;
      for (var value in document.values) {
        shiftReportSheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex, rowIndex: rowIndex + 1))
            .value = value;
        columnIndex++;
      }
    }

    // if (await Permission.storage.request().isGranted) {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      String filePath = '$selectedDirectory/وردية$dateString.xlsx';
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      return Right(Success());
    } else {
      return Left(Failures(errorMessage: "لم يتم حفظ التقرير"));
    }
    // }
  }

  Future<Either<Failures, Success>> createTripReportExcel(
      List<TripReport> data, String date) async {
    String dateString = MyFunctions.millisecondsToFormattedDate(date);

    var excel = Excel.createExcel();
    Sheet tripReportSheet = excel['Sheet1'];
    excel.setDefaultSheet(tripReportSheet.sheetName);

    // Add headers (assuming all documents have the same structure)
    int index = 0;
    Map<String, dynamic> firstDocument =
        data[index].toExcelSheet(data[index].toFirestore());
    int columnIndex = 0;
    for (var key in firstDocument.keys) {
      tripReportSheet
          .cell(
              CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: 0))
          .value = key;

      columnIndex++;
    }
    // Add data
    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      Map<String, dynamic> document =
          data[rowIndex].toExcelSheet(data[rowIndex].toFirestore());
      int columnIndex = 0;
      for (var value in document.values) {
        tripReportSheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex, rowIndex: rowIndex + 1))
            .value = value;
        columnIndex++;
      }
    }

    // if (await Permission.storage.request().isGranted) {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      String filePath = '$selectedDirectory/سفرية$dateString.xlsx';
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      return Right(Success());
    } else {
      return Left(Failures(errorMessage: "لم يتم حفظ التقرير"));
    }
    // }
  }
}
