import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFunctions {
  static formatDateString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 31)),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      return selectedDate;
    } else {
      return null;
    }
  }

  static Future<String?> selectTime(BuildContext context, String date) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    DateTime? now = DateTime.parse(date);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final format =
          DateFormat.Hm(); // Or use DateFormat.Hm() for 24-hour format
      final formattedDate = format.format(dt);
      return formattedDate;
    } else {
      return null;
    }
  }

  static String millisecondsToFormattedDate(String milliseconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
