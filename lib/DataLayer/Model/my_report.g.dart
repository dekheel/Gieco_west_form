// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralReportDataAdapter extends TypeAdapter<GeneralReportData> {
  @override
  final int typeId = 5;

  @override
  GeneralReportData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralReportData(
      locoNo: fields[0] as String?,
      locoDate: fields[1] as String?,
      globalNote: fields[3] as String?,
      locoCapNotes: fields[2] as String?,
      user: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralReportData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.locoNo)
      ..writeByte(1)
      ..write(obj.locoDate)
      ..writeByte(2)
      ..write(obj.locoCapNotes)
      ..writeByte(3)
      ..write(obj.globalNote)
      ..writeByte(4)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralReportDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FuelReportDataAdapter extends TypeAdapter<FuelReportData> {
  @override
  final int typeId = 4;

  @override
  FuelReportData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelReportData(
      isFuel: fields[0] as bool?,
      fuelInvoiceNo: fields[1] as String?,
      fuelType: fields[2] as String?,
      gazQty: fields[3] as String?,
      oilQty: fields[4] as String?,
      invoiceImagePath: fields[5] as String?,
    )..invoiceImage = fields[6] as File?;
  }

  @override
  void write(BinaryWriter writer, FuelReportData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.isFuel)
      ..writeByte(1)
      ..write(obj.fuelInvoiceNo)
      ..writeByte(2)
      ..write(obj.fuelType)
      ..writeByte(3)
      ..write(obj.gazQty)
      ..writeByte(4)
      ..write(obj.oilQty)
      ..writeByte(5)
      ..write(obj.invoiceImagePath)
      ..writeByte(6)
      ..write(obj.invoiceImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelReportDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StockTripReportDataAdapter extends TypeAdapter<StockTripReportData> {
  @override
  final int typeId = 3;

  @override
  StockTripReportData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockTripReportData(
      trainEmpty: fields[3] as String?,
      tempStation: fields[10] as String?,
      sebensaNo: fields[8] as String?,
      lastCoachNo: fields[7] as String?,
      firstCoachNo: fields[6] as String?,
      tariff: fields[5] as String?,
      trainState: fields[2] as String?,
      coachQuantity: fields[1] as String?,
      trainSecurity: fields[9] as String?,
      trainType: fields[0] as String?,
      waybillNo: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StockTripReportData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.trainType)
      ..writeByte(1)
      ..write(obj.coachQuantity)
      ..writeByte(2)
      ..write(obj.trainState)
      ..writeByte(3)
      ..write(obj.trainEmpty)
      ..writeByte(4)
      ..write(obj.waybillNo)
      ..writeByte(5)
      ..write(obj.tariff)
      ..writeByte(6)
      ..write(obj.firstCoachNo)
      ..writeByte(7)
      ..write(obj.lastCoachNo)
      ..writeByte(8)
      ..write(obj.sebensaNo)
      ..writeByte(9)
      ..write(obj.trainSecurity)
      ..writeByte(10)
      ..write(obj.tempStation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockTripReportDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmployeeReportDataAdapter extends TypeAdapter<EmployeeReportData> {
  @override
  final int typeId = 2;

  @override
  EmployeeReportData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeReportData(
      trainCap: fields[0] as String?,
      trainCapAsstSap: fields[3] as String?,
      trainCapSap: fields[1] as String?,
      trainCapAsst: fields[2] as String?,
      trainConductor: fields[4] as String?,
      trainConductorSap: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeReportData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.trainCap)
      ..writeByte(1)
      ..write(obj.trainCapSap)
      ..writeByte(2)
      ..write(obj.trainCapAsst)
      ..writeByte(3)
      ..write(obj.trainCapAsstSap)
      ..writeByte(4)
      ..write(obj.trainConductor)
      ..writeByte(5)
      ..write(obj.trainConductorSap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeReportDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TripReportAdapter extends TypeAdapter<TripReport> {
  @override
  final int typeId = 0;

  @override
  TripReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripReport(
      fuelReportData: fields[1] as FuelReportData?,
      generalReportData: fields[2] as GeneralReportData?,
      employeeReportData: fields[11] as EmployeeReportData?,
      stockTripReportData: fields[0] as StockTripReportData?,
      gazOnArr: fields[10] as String?,
      depStation: fields[4] as String?,
      gazOnDep: fields[9] as String?,
      depTime: fields[7] as String?,
      arrTime: fields[8] as String?,
      nxtArrFromdepStation: fields[5] as String?,
      tripType: fields[3] as String?,
      arrStation: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TripReport obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.stockTripReportData)
      ..writeByte(1)
      ..write(obj.fuelReportData)
      ..writeByte(2)
      ..write(obj.generalReportData)
      ..writeByte(3)
      ..write(obj.tripType)
      ..writeByte(4)
      ..write(obj.depStation)
      ..writeByte(5)
      ..write(obj.nxtArrFromdepStation)
      ..writeByte(6)
      ..write(obj.arrStation)
      ..writeByte(7)
      ..write(obj.depTime)
      ..writeByte(8)
      ..write(obj.arrTime)
      ..writeByte(9)
      ..write(obj.gazOnDep)
      ..writeByte(10)
      ..write(obj.gazOnArr)
      ..writeByte(11)
      ..write(obj.employeeReportData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ShiftReportAdapter extends TypeAdapter<ShiftReport> {
  @override
  final int typeId = 1;

  @override
  ShiftReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftReport(
      employeeReportData: fields[8] as EmployeeReportData?,
      gazOnArr: fields[7] as String?,
      arrTime: fields[5] as String?,
      depTime: fields[4] as String?,
      gazOnDep: fields[6] as String?,
      depStation: fields[3] as String?,
      shiftType: fields[2] as String?,
      fuelReportData: fields[0] as FuelReportData?,
      generalReportData: fields[1] as GeneralReportData?,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftReport obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.fuelReportData)
      ..writeByte(1)
      ..write(obj.generalReportData)
      ..writeByte(2)
      ..write(obj.shiftType)
      ..writeByte(3)
      ..write(obj.depStation)
      ..writeByte(4)
      ..write(obj.depTime)
      ..writeByte(5)
      ..write(obj.arrTime)
      ..writeByte(6)
      ..write(obj.gazOnDep)
      ..writeByte(7)
      ..write(obj.gazOnArr)
      ..writeByte(8)
      ..write(obj.employeeReportData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
