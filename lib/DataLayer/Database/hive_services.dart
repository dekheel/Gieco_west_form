import 'package:gieco_west/DataLayer/Model/my_report.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  HiveService._();

  static HiveService? _instance;

  static HiveService getInstance() {
    _instance ??= HiveService._();
    return _instance!;
  }

  Future<void> init() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    Hive.init(appDocumentDir.path);
  }

  Future<void> addShiftData(String boxName, ShiftReport reports) async {
    var reportBox = await Hive.openBox<ShiftReport>(boxName);
    await reportBox.add(reports);
    reportBox.close();
  }

  Future<void> addTripData(String boxName, TripReport reports) async {
    var reportBox = await Hive.openBox<TripReport>(boxName);
    await reportBox.add(reports);
    reportBox.close();
  }

  Future<List<dynamic>> getShiftData(String boxName) async {
    var reportBox = await Hive.openBox<ShiftReport>(boxName);
    List<ShiftReport> data = reportBox.values.toList();
    reportBox.close();
    return data;
  }

  Future<List<dynamic>> getTripData(String boxName) async {
    var reportBox = await Hive.openBox<TripReport>(boxName);
    List<TripReport> data = reportBox.values.toList();
    reportBox.close();
    return data;
  }

  Stream watch(Box box) {
    return box.watch();
  }

  Future<void> delete(Box box, String key) async {
    await box.delete(key);
  }

  Future<void> clear(Box box) async {
    await box.clear();
  }

  bool containsKey(Box box, String key) {
    return box.containsKey(key);
  }
}
