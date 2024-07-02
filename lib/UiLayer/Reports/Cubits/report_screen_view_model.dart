import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/UiLayer/Reports/report_states.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:string_validator/string_validator.dart';

class ReportScreenViewModel extends Cubit<CreateReportStates> {
  ReportScreenViewModel() : super(CreateReportInitialState());

  TextEditingController reportDateCtrl = TextEditingController();
  TextEditingController reportTypeCtrl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void createReport() async {
    if (formKey.currentState!.validate()) {
      emit(CreateReportLoadingState());
      var either = reportTypeCtrl.text == "سفرية"
          ? await FirebaseUtils.getInstance().createTripReportFirestore(
              MyFunctions.formatDateString(DateTime.parse(reportDateCtrl.text)))
          : await FirebaseUtils.getInstance().createShiftReportFirestore(
              MyFunctions.formatDateString(
                  DateTime.parse(reportDateCtrl.text)));

      either.fold((l) {
        emit(CreateReportErrorState(errorMsg: l.errorMessage));
      }, (response) {
        emit(CreateReportSuccessState());
      });
    }
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

  // Future<void> getStorageAccess() async {
  //   await Permission.storage.request();
  // }
}
