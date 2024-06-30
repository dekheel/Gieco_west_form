import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/SharedPreferences/shared_preferences.dart';
import 'package:gieco_west/UiLayer/AuthScreens/auth_states.dart';
import 'package:string_validator/string_validator.dart';

class LoginScreenViewModel extends Cubit<AuthStates> {
  LoginScreenViewModel() : super(AuthInitialState());

  // todo: hold data
  DateTime? lastPressedAt;
  bool canPop = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool obsecurePass = true;

// todo: handle functions

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(AuthLoadingState());
      var either = await FirebaseUtils.getInstance()
          .signInFirebase(emailCtrl.text, passwordCtrl.text, context);
      either.fold((l) {
        emit(AuthErrorState(errorMsg: l.errorMessage));
      }, (response) {
        emit(AuthSuccessState());
      });
    }
  }

  String? emailFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (!isEmail(value)) {
      return "يجب ادخال البريد الالكتروني بطريقة صحيحة";
    }
    return null;
  }

  String? passFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  void showPassword() {
    if (obsecurePass) {
      emit(HidePassState());
    } else {
      emit(ShowPassState());
    }
  }

  Future getuserEmailPass() async {
    var user = await SharedPreference.readUserData();
    emailCtrl.text = user?.email ?? "";
  }
}
