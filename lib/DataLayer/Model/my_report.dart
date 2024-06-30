import 'dart:io';

import 'package:intl/intl.dart';

class GeneralReportData {
  GeneralReportData(
      {this.locoNo,
      this.locoDate,
      this.globalNote,
      this.locoCapNotes,
      this.user});
  String? locoNo;
  DateTime? locoDate;
  String? locoCapNotes;
  String? globalNote;
  String? user;

  Map<String, dynamic> toFirestore() {
    return {
      "locoNo": locoNo,
      "locoDate": locoDate?.millisecondsSinceEpoch,
      "locoCapNotes": locoCapNotes,
      "globalNote": globalNote,
      "user": user,
    };
  }

  GeneralReportData.fromFirestore(Map<String, dynamic>? data)
      : this(
            locoNo: data?["locoNo"],
            locoDate: DateTime.fromMillisecondsSinceEpoch(data?["locoDate"]),
            locoCapNotes: data?["locoCapNotes"],
            globalNote: data?["globalNote"],
            user: data?["user"]);
}

class FuelReportData {
  FuelReportData({
    this.isFuel,
    this.fuelInvoiceNo,
    this.fuelType,
    this.gazQty,
    this.oilQty,
    this.invoiceImagePath,
  });
  String? fuelInvoiceNo;
  bool? isFuel;
  String? fuelType;
  double? gazQty;
  double? oilQty;

  String? invoiceImagePath;
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
            gazQty: data["gazQty"],
            oilQty: data["oilQty"]);
}

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

  String? trainType;
  String? coachQuantity;
  String? trainState;
  String? trainEmpty;
  String? waybillNo;
  String? tariff;
  String? firstCoachNo;
  String? lastCoachNo;
  String? sebensaNo;
  String? trainSecurity;
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

class EmployeeReportData {
  EmployeeReportData(
      {this.trainCap,
      this.trainCapAsstSap,
      this.trainCapSap,
      this.trainCapAsst,
      this.trainConductor,
      this.trainConductorSap});
  // trip emp info
  String? trainCap;
  String? trainCapSap;
  String? trainCapAsst;
  String? trainCapAsstSap;
  String? trainConductor;
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
  StockTripReportData? stockTripReportData;
  FuelReportData? fuelReportData;
  GeneralReportData? generalReportData;
  // trip info
  String? tripType;
  String? depStation;
  String? nxtArrFromdepStation;
  String? arrStation;
  String? depTime;
  String? arrTime;
  double? gazOnDep;
  double? gazOnArr;

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
      "تاريخ السفرية": DateFormat("yyyy-MM-dd").format(
          DateTime.fromMillisecondsSinceEpoch(
              data["generalReportData"]["locoDate"])),
      "ملاحظات القائد": data["generalReportData"]["locoCapNotes"],
      "التموين": data["fuelReportData"]["isFuel"] ? "نعم" : "لا",
      "رقم البون": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["fuelInvoiceNo"]
          : "لا",
      "نوع التموين": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["fuelType"]
          : "لا",
      "كمية السولار المنصرفة": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["gazQty"]
          : "لا",
      "كمية الزيت المنصرفة": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["oilQty"]
          : "لا",
      "صورة البون": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["invoiceImagePath"]
          : "لا",
      "نوع القطار": data["stockTripReportData"]["trainType"],
      "حالة القطار": data["stockTripReportData"]["trainState"],
      "رقم البوليصة": data["stockTripReportData"]["trainState"] == "مشحون"
          ? data["stockTripReportData"]["waybillNo"]
          : "لا",
      "برسم": data["stockTripReportData"]["tariff"],
      "عدد العربات": data["stockTripReportData"]["coachQuantity"],
      "رقم اول عربة": data["stockTripReportData"]["firstCoachNo"],
      "رقم اخر عربة": data["stockTripReportData"]["lastCoachNo"],
      "رقم السبنسة": data["stockTripReportData"]["sebensaNo"],
      "اماكن التخزين": data["stockTripReportData"]["tempStation"],
      "أمن القطار": data["stockTripReportData"]["trainSecurity"],
      "نوع الرحلة": data["tripType"],
      "محطة القيام": data["tripType"] == "قيام" ? data["depStation"] : "لا",
      "وقت القيام": data["tripType"] == "قيام" ? data["depTime"] : "لا",
      "السولار عند القيام":
          data["tripType"] == "قيام" ? data["gazOnDep"] : "لا",
      "محطة الوصول التالية":
          data["tripType"] == "قيام" ? data["nxtArrFromdepStation"] : "لا",
      "محطة الوصول": data["tripType"] == "وصول" ? data["arrStation"] : "لا",
      "وقت الوصول": data["tripType"] == "وصول" ? data["arrTime"] : "لا",
      "السولار عند الوصول":
          data["tripType"] == "وصول" ? data["gazOnArr"] : "لا",
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
          gazOnDep: data["gazOnDep"],
          gazOnArr: data["gazOnArr"],
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
          stockTripReportData:
              StockTripReportData.fromFirestore(data["stockTripReportData"]),
        );
}

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
  FuelReportData? fuelReportData;
  GeneralReportData? generalReportData;
  String? shiftType;
  String? depStation;
  String? depTime;
  String? arrTime;
  double? gazOnDep;
  double? gazOnArr;
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
          gazOnDep: data["gazOnDep"] as double,
          gazOnArr: data["gazOnArr"] as double,
          generalReportData:
              GeneralReportData.fromFirestore(data["generalReportData"]),
          fuelReportData: FuelReportData.fromFirestore(data["fuelReportData"]),
          employeeReportData:
              EmployeeReportData.fromFirestore(data["employeeReportData"]),
        );

  Map<String, dynamic> toExcelSheet(Map<String, dynamic> data) {
    return {
      "رقم الجرار-القطار": data["generalReportData"]["locoNo"],
      "تاريخ السفرية": DateFormat("yyyy-MM-dd").format(
          DateTime.fromMillisecondsSinceEpoch(
              data["generalReportData"]["locoDate"])),
      "ملاحظات القائد": data["generalReportData"]["locoCapNotes"],
      "التموين": data["fuelReportData"]["isFuel"] ? "نعم" : "لا",
      "رقم البون": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["fuelInvoiceNo"]
          : "لا",
      "نوع التموين": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["fuelType"]
          : "لا",
      "كمية السولار المنصرفة": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["gazQty"]
          : "لا",
      "كمية الزيت المنصرفة": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["oilQty"]
          : "لا",
      "صورة البون": data["fuelReportData"]["isFuel"]
          ? data["fuelReportData"]["invoiceImagePath"]
          : "لا",
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
