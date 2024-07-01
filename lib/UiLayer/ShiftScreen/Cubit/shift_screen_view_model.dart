import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Model/my_report.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/TripScreen/report_states.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class ShiftScreenViewModel extends Cubit<ReportStates> {
  ShiftScreenViewModel({Key? key}) : super(ReportInitialState());

  // hold data
  DateTime? lastPressedAt;
  bool canPop = false;

  int currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

//    //basic info
  TextEditingController locoNoCtrl = TextEditingController();
  TextEditingController locoDateCtrl = TextEditingController();
  TextEditingController locoCapNotesCtrl =
      TextEditingController(text: "لا يوجد");

  //fuel info
  bool isFuel = false;
  TextEditingController fuelInvoiceNoCtrl = TextEditingController();
  String? fuelType;
  TextEditingController gazQtyCtrl = TextEditingController();
  TextEditingController oilQtyCtrl = TextEditingController();
  File? pickedImage;
  TextEditingController fuelInvoiceUrlCtrl = TextEditingController();

  //Shift  info
  TextEditingController shiftTypeCtrl = TextEditingController();
  TextEditingController depStationCtrl =
      TextEditingController(text: "الاسكندرية");
  TextEditingController depTimeCtrl = TextEditingController(text: "15:55");
  TextEditingController arrTimeCtrl = TextEditingController(text: "15:55");
  TextEditingController gazOnDepCtrl = TextEditingController(text: "1500");
  TextEditingController gazOnArrCtrl = TextEditingController(text: "100");

  //Shift emp info
  TextEditingController trainCapCtrl = TextEditingController();
  TextEditingController trainCapSapCtrl = TextEditingController();
  TextEditingController trainCapAsstCtrl = TextEditingController();
  TextEditingController trainCapAsstSapCtrl = TextEditingController();

// global note
  TextEditingController globalNoteCtrl = TextEditingController(text: "لا يوجد");

  // handle logic
  void addReport(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      emit(ReportLoadingState());
      await Future.delayed(Duration(seconds: 5));

      var either = await FirebaseUtils.getInstance().addShiftReportToFirestore(
          getReportModel(context), userProvider.currentUser?.id ?? "");
      either.fold((l) {
        emit(ReportErrorState(errorMsg: l.errorMessage));
      }, (response) {
        emit(ReportSuccessState());
        resetForm();
      });
    }
  }

  void uploadImage(
      BuildContext context, File pickedImageFile, String title) async {
    emit(UploadImageLoadingState());
    var uploadEither =
        await FirebaseUtils.getInstance().uploadImage(pickedImageFile, title);

    var urlEither = await FirebaseUtils.getInstance().getImageUrl(title);
    uploadEither.fold((l) {
      emit(UploadImageErrorState(errorMsg: l.errorMessage));
    }, (response) {
      emit(UploadImageSuccessState());
    });

    urlEither.fold((l) {
      emit(UploadImageErrorState(errorMsg: l.errorMessage));
    }, (response) {
      fuelInvoiceUrlCtrl.text = response!;
      emit(UploadImageSuccessState());
    });
  }

  String? numberFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (!isNumeric(value)) {
      return "يجب ادخال رقم فقط";
    }
    return null;
  }

  void onTrainCapChanged() {
    trainCapSapCtrl.clear();
  }

  String? sapFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "مطلوب";
    }
    if (!isNumeric(value)) {
      return "رقم فقط";
    }
    return null;
  }

  String? textFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (isNumeric(value)) {
      return "يجب ادخال نص فقط";
    }
    return null;
  }

  String? dateFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (!isDate(value)) {
      return "يجب ادخال تاريخ فقط";
    }
    return null;
  }

  String? commonFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  String getMyUser(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    return provider.currentUser!.name!;
  }

  ShiftReport getReportModel(BuildContext context) {
    ShiftReport reportModel = ShiftReport(
      generalReportData: GeneralReportData(
        locoNo: locoNoCtrl.text,
        locoDate: DateTime.parse(locoDateCtrl.text),
        locoCapNotes: locoCapNotesCtrl.text,
        globalNote:
            globalNoteCtrl.text.isEmpty ? "لا يوجد" : globalNoteCtrl.text,
        user: getMyUser(context),
      ),
      fuelReportData: FuelReportData(
        isFuel: isFuel,
        fuelInvoiceNo: fuelInvoiceNoCtrl.text,
        fuelType: fuelType,
        gazQty: gazQtyCtrl.text.toDouble(),
        oilQty: oilQtyCtrl.text.toDouble(),
        invoiceImagePath: fuelInvoiceUrlCtrl.text,
      ),
      employeeReportData: EmployeeReportData(
        trainCap: trainCapCtrl.text,
        trainCapSap: trainCapSapCtrl.text,
        trainCapAsst: trainCapAsstCtrl.text,
        trainCapAsstSap: trainCapAsstSapCtrl.text,
      ),
      shiftType: shiftTypeCtrl.text,
      depStation: depStationCtrl.text,
      depTime: depTimeCtrl.text,
      arrTime: arrTimeCtrl.text,
      gazOnDep: gazOnDepCtrl.text.toDouble(),
      gazOnArr: gazOnArrCtrl.text.toDouble(),
    );
    return reportModel;
  }

  void resetForm() {
    emit(ResetFormState());
    // hold data
    currentStep = 0;
    isCompleted = false; //check completeness of inputs

    pickedImage = null;
    fuelInvoiceUrlCtrl.clear();

//    //basic info
    locoNoCtrl.clear();
    locoNoCtrl.clear();
    locoDateCtrl.clear();
    locoCapNotesCtrl.clear();

    //fuel info
    isFuel = false;
    fuelInvoiceNoCtrl.clear();
    fuelType = "";
    gazQtyCtrl.clear();
    oilQtyCtrl.clear();

    //Shift  info
    shiftTypeCtrl.clear();
    depStationCtrl.clear();
    depTimeCtrl.clear();
    arrTimeCtrl.clear();
    gazOnDepCtrl.clear();
    gazOnArrCtrl.clear();

    //Shift emp info
    trainCapCtrl.clear();
    trainCapSapCtrl.clear();
    trainCapAsstCtrl.clear();
    trainCapAsstSapCtrl.clear();

// global note
    globalNoteCtrl.clear();
  }

  void onTrainCapAsstChanged() {
    trainCapAsstSapCtrl.clear();
  }
}
