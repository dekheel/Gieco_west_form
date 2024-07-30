import 'dart:io';

import 'package:hive/hive.dart';

part 'my_report.g.dart';

@HiveType(typeId: 5)
class GeneralReportData {
  GeneralReportData(
      {this.locoNo,
      this.locoDate,
      this.globalNote,
      this.locoCapNotes,
      this.user});

  @HiveField(0)
  String? locoNo;
  @HiveField(1)
  String? locoDate;
  @HiveField(2)
  String? locoCapNotes;
  @HiveField(3)
  String? globalNote;
  @HiveField(4)
  String? user;

  Map<String, dynamic> toFirestore() {
    return {
      "locoNo": locoNo,
      "locoDate": locoDate,
      "locoCapNotes": locoCapNotes,
      "globalNote": globalNote,
      "user": user,
    };
  }

  GeneralReportData.fromFirestore(Map<String, dynamic>? data)
      : this(
            locoNo: data?["locoNo"],
            locoDate: data?["locoDate"],
            locoCapNotes: data?["locoCapNotes"],
            globalNote: data?["globalNote"],
            user: data?["user"]);
}

@HiveType(typeId: 4)
class FuelReportData {
  FuelReportData({
    this.isFuel,
    this.fuelInvoiceNo,
    this.fuelType,
    this.gazQty,
    this.oilQty,
    this.invoiceImagePath,
  });

  @HiveField(0)
  bool? isFuel;
  @HiveField(1)
  String? fuelInvoiceNo;
  @HiveField(2)
  String? fuelType;
  @HiveField(3)
  String? gazQty;
  @HiveField(4)
  String? oilQty;
  @HiveField(5)
  String? invoiceImagePath;
  @HiveField(6)
  File? invoiceImage;

  Map<String, dynamic> toFirestore() {
    return {
      "fuelInvoiceNo": fuelInvoiceNo,
      "isFuel": isFuel,
      "fuelType": fuelType,
      "gazQty": gazQty,
      "oilQty": oilQty,
      "invoiceImagePath": invoiceImagePath,
    };
  }

  FuelReportData.fromFirestore(Map<String, dynamic>? data)
      : this(
            fuelInvoiceNo: data!["fuelInvoiceNo"],
            isFuel: data["isFuel"],
            fuelType: data["fuelType"],
            invoiceImagePath: data["invoiceImagePath"],
            gazQty: data["gazQty"].toString(),
            oilQty: data["oilQty"].toString());
}

@HiveType(typeId: 3)
class StockTripReportData {
  StockTripReportData(
      {this.trainEmpty,
      this.tempStation,
      this.sebensaNo,
      this.lastCoachNo,
      this.firstCoachNo,
      this.tariff,
      this.trainState,
      this.coachQuantity,
      this.trainSecurity,
      this.trainType,
      this.waybillNo});

  @HiveField(0)
  String? trainType;
  @HiveField(1)
  String? coachQuantity;
  @HiveField(2)
  String? trainState;
  @HiveField(3)
  String? trainEmpty;
  @HiveField(4)
  String? waybillNo;
  @HiveField(5)
  String? tariff;
  @HiveField(6)
  String? firstCoachNo;
  @HiveField(7)
  String? lastCoachNo;
  @HiveField(8)
  String? sebensaNo;
  @HiveField(9)
  String? trainSecurity;
  @HiveField(10)
  String? tempStation;

  Map<String, dynamic> toFirestore() {
    return {
      "trainType": trainType,
      "coachQuantity": coachQuantity,
      "trainState": trainState,
      "trainEmpty": trainEmpty,
      "waybillNo": waybillNo,
      "tariff": tariff,
      "firstCoachNo": firstCoachNo,
      "lastCoachNo": lastCoachNo,
      "sebensaNo": sebensaNo,
      "trainSecurity": trainSecurity,
      "tempStation": tempStation,
    };
  }

  StockTripReportData.fromFirestore(Map<String, dynamic>? data)
      : this(
          trainType: data!["trainType"],
          coachQuantity: data["coachQuantity"],
          trainState: data["trainState"],
          trainEmpty: data["trainEmpty"],
          waybillNo: data["waybillNo"],
          tariff: data["tariff"],
          firstCoachNo: data["firstCoachNo"],
          lastCoachNo: data["lastCoachNo"],
          sebensaNo: data["sebensaNo"],
          trainSecurity: data["trainSecurity"],
          tempStation: data["tempStation"],
        );
}

@HiveType(typeId: 2)
class EmployeeReportData {
  EmployeeReportData(
      {this.trainCap,
      this.trainCapAsstSap,
      this.trainCapSap,
      this.trainCapAsst,
      this.trainConductor,
      this.trainConductorSap});
  // trip emp info
  @HiveField(0)
  String? trainCap;
  @HiveField(1)
  String? trainCapSap;
  @HiveField(2)
  String? trainCapAsst;
  @HiveField(3)
  String? trainCapAsstSap;
  @HiveField(4)
  String? trainConductor;
  @HiveField(5)
  String? trainConductorSap;
  Map<String, dynamic> toFirestore() {
    return {
      "trainCap": trainCap,
      "trainCapSap": trainCapSap,
      "trainCapAsst": trainCapAsst,
      "trainCapAsstSap": trainCapAsstSap,
      "trainConductor": trainConductor,
      "trainConductorSap": trainConductorSap,
    };
  }

  EmployeeReportData.fromFirestore(Map<String, dynamic>? data)
      : this(
          trainCap: data!["trainCap"],
          trainCapSap: data["trainCapSap"],
          trainCapAsst: data["trainCapAsst"],
          trainCapAsstSap: data["trainCapAsstSap"],
          trainConductor: data["trainConductor"],
          trainConductorSap: data["trainConductorSap"],
        );
}

@HiveType(typeId: 0)
class TripReport {
  static String collectionName = "TripReports";
  TripReport(
      {this.fuelReportData,
      this.generalReportData,
      this.employeeReportData,
      this.stockTripReportData,
      this.gazOnArr,
      this.depStation,
      this.gazOnDep,
      this.depTime,
      this.arrTime,
      this.nxtArrFromdepStation,
      this.tripType,
      this.arrStation});
  // stock trip info

  @HiveField(0)
  StockTripReportData? stockTripReportData;
  @HiveField(1)
  FuelReportData? fuelReportData;
  @HiveField(2)
  GeneralReportData? generalReportData;
  // trip info
  @HiveField(3)
  String? tripType;
  @HiveField(4)
  String? depStation;
  @HiveField(5)
  String? nxtArrFromdepStation;
  @HiveField(6)
  String? arrStation;
  @HiveField(7)
  String? depTime;
  @HiveField(8)
  String? arrTime;
  @HiveField(9)
  String? gazOnDep;
  @HiveField(10)
  String? gazOnArr;
  @HiveField(11)
  EmployeeReportData? employeeReportData;

  Map<String, dynamic> toFirestore() {
    return {
      "tripType": tripType,
      "depStation": depStation,
      "nxtArrFromdepStation": nxtArrFromdepStation,
      "arrStation": arrStation,
      "depTime": depTime,
      "arrTime": arrTime,
      "gazOnDep": gazOnDep,
      "gazOnArr": gazOnArr,
      "generalReportData": generalReportData?.toFirestore(),
      "fuelReportData": fuelReportData?.toFirestore(),
      "employeeReportData": employeeReportData?.toFirestore(),
      "stockTripReportData": stockTripReportData?.toFirestore()
    };
  }

  Map<String, dynamic> toExcelSheet(Map<String, dynamic> data) {
    return {
      "رقم الجرار-القطار": data["generalReportData"]["locoNo"],
      "تاريخ السفرية": data["generalReportData"]["locoDate"],
      "ملاحظات القائد": data["generalReportData"]["locoCapNotes"],
      "التموين": data["fuelReportData"]["isFuel"] == true ? "نعم" : "لا",
      "رقم البون": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["fuelInvoiceNo"]
          : "-",
      "نوع التموين": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["fuelType"]
          : "-",
      "كمية السولار المنصرفة": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["gazQty"]
          : "-",
      "كمية الزيت المنصرفة": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["oilQty"]
          : "-",
      "صورة البون": (data["fuelReportData"]["isFuel"] == true &&
              data["fuelReportData"]["invoiceImagePath"] != null &&
              data["fuelReportData"]["invoiceImagePath"] != "")
          ? data["fuelReportData"]["invoiceImagePath"]
          : "-",
      "نوع القطار": data["stockTripReportData"]["trainType"],
      "حالة القطار": data["stockTripReportData"]["trainState"],
      "رقم البوليصة": data["stockTripReportData"]["trainState"] == "مشحون"
          ? data["stockTripReportData"]["waybillNo"]
          : "-",
      "برسم": data["stockTripReportData"]["tariff"],
      "عدد العربات": data["stockTripReportData"]["coachQuantity"],
      "رقم اول عربة": data["stockTripReportData"]["firstCoachNo"],
      "رقم اخر عربة": data["stockTripReportData"]["lastCoachNo"],
      "رقم السبنسة": data["stockTripReportData"]["sebensaNo"],
      "اماكن التخزين": data["stockTripReportData"]["tempStation"],
      "أمن القطار": data["stockTripReportData"]["trainSecurity"],
      "محطة القيام": data["depStation"],
      "وقت القيام": data["depTime"],
      "السولار عند القيام": data["gazOnDep"],
      "محطة الوصول التالية": data["nxtArrFromdepStation"],
      "محطة الوصول": data["arrStation"],
      "وقت الوصول": data["arrTime"],
      "السولار عند الوصول": data["gazOnArr"],
      "قائد القطار": data["employeeReportData"]["trainCap"],
      "ساب القائد": data["employeeReportData"]["trainCapSap"],
      "م قائد القطار": data["employeeReportData"]["trainCapAsst"],
      "ساب المساعد": data["employeeReportData"]["trainCapAsstSap"],
      "مشرف القطار": data["employeeReportData"]["trainConductor"],
      "ساب المشرف": data["employeeReportData"]["trainConductorSap"],
      "ملاحظات": data["generalReportData"]["globalNote"],
      "المختص": data["generalReportData"]["user"],
    };
  }

  TripReport.fromFirestore(Map<String, dynamic>? data)
      : this(
          tripType: data!["tripType"],
          depStation: data["depStation"],
          nxtArrFromdepStation: data["nxtArrFromdepStation"],
          arrStation: data["arrStation"],
          depTime: data["depTime"],
          arrTime: data["arrTime"],
          gazOnDep: data["gazOnDep"].toString(),
          gazOnArr: data["gazOnArr"].toString(),
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
          stockTripReportData:
              StockTripReportData.fromFirestore(data["stockTripReportData"]),
        );

  TripReport.fromHive(Map<dynamic, dynamic> data)
      : this(
          tripType: data["tripType"],
          depStation: data["depStation"],
          nxtArrFromdepStation: data["nxtArrFromdepStation"],
          arrStation: data["arrStation"],
          depTime: data["depTime"],
          arrTime: data["arrTime"],
          gazOnDep: data["gazOnDep"].toString(),
          gazOnArr: data["gazOnArr"].toString(),
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
          stockTripReportData:
              StockTripReportData.fromFirestore(data["stockTripReportData"]),
        );
}

@HiveType(typeId: 1)
class ShiftReport {
  static String collectionName = "ShiftReports";

  ShiftReport({
    this.employeeReportData,
    this.gazOnArr,
    this.arrTime,
    this.depTime,
    this.gazOnDep,
    this.depStation,
    this.shiftType,
    this.fuelReportData,
    this.generalReportData,
  });

  // shift info

  @HiveField(0)
  FuelReportData? fuelReportData;
  @HiveField(1)
  GeneralReportData? generalReportData;
  @HiveField(2)
  String? shiftType;
  @HiveField(3)
  String? depStation;
  @HiveField(4)
  String? depTime;
  @HiveField(5)
  String? arrTime;
  @HiveField(6)
  String? gazOnDep;
  @HiveField(7)
  String? gazOnArr;
  @HiveField(8)
  EmployeeReportData? employeeReportData;

  Map<String, dynamic> toFirestore() {
    return {
      "shiftType": shiftType,
      "depStation": depStation,
      "depTime": depTime,
      "arrTime": arrTime,
      "gazOnDep": gazOnDep,
      "gazOnArr": gazOnDep,
      "generalReportData": generalReportData?.toFirestore(),
      "fuelReportData": fuelReportData?.toFirestore(),
      "employeeReportData": employeeReportData?.toFirestore()
    };
  }

  ShiftReport.fromFirestore(Map<String, dynamic>? data)
      : this(
          shiftType: data!["shiftType"] as String,
          depStation: data["depStation"] as String,
          depTime: data["depTime"],
          arrTime: data["arrTime"],
          gazOnDep: data["gazOnDep"].toString(),
          gazOnArr: data["gazOnArr"].toString(),
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
        );

  ShiftReport.fromHive(Map<dynamic, dynamic> data)
      : this(
          shiftType: data["shiftType"] as String,
          depStation: data["depStation"] as String,
          depTime: data["depTime"],
          arrTime: data["arrTime"],
          gazOnDep: data["gazOnDep"].toString(),
          gazOnArr: data["gazOnArr"].toString(),
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
        );

  Map<String, dynamic> toExcelSheet(Map<String, dynamic> data) {
    return {
      "رقم الجرار-القطار": data["generalReportData"]["locoNo"],
      "تاريخ الوردية": data["generalReportData"]["locoDate"],
      "ملاحظات القائد": data["generalReportData"]["locoCapNotes"],
      "التموين": data["fuelReportData"]["isFuel"] == true ? "نعم" : "لا",
      "رقم البون": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["fuelInvoiceNo"]
          : "-",
      "نوع التموين": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["fuelType"]
          : "-",
      "كمية السولار المنصرفة": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["gazQty"]
          : "-",
      "كمية الزيت المنصرفة": data["fuelReportData"]["isFuel"] == true
          ? data["fuelReportData"]["oilQty"]
          : "-",
      "صورة البون": (data["fuelReportData"]["isFuel"] == true &&
              data["fuelReportData"]["invoiceImagePath"] != null &&
              data["fuelReportData"]["invoiceImagePath"] != "")
          ? data["fuelReportData"]["invoiceImagePath"]
          : "-",
      "نوع الوردية": data["shiftType"],
      "محطة الوردية": data["depStation"],
      "ساعة بداية الوردية": data["depTime"],
      "كمية السولار عند بدء الوردية": data["gazOnDep"],
      "ساعة نهاية الوردية": data["arrTime"],
      "كمية السولار عند انتهاء الوردية": data["gazOnArr"],
      "قائد القطار": data["employeeReportData"]["trainCap"],
      "ساب القائد": data["employeeReportData"]["trainCapSap"],
      "م قائد القطار": data["employeeReportData"]["trainCapAsst"],
      "ساب المساعد": data["employeeReportData"]["trainCapAsstSap"],
      "ملاحظات": data["generalReportData"]["globalNote"],
      "المختص": data["generalReportData"]["user"],
    };
  }
}
