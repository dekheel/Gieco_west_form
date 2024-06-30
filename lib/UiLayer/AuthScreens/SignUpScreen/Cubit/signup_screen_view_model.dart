import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:gieco_west/UiLayer/AuthScreens/auth_states.dart';
import 'package:string_validator/string_validator.dart';

class SignUpScreenViewModel extends Cubit<AuthStates> {
  SignUpScreenViewModel() : super(AuthInitialState());

  // todo: hold data
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl1 = TextEditingController();
  final passwordCtrl2 = TextEditingController();

  final nameCtrl = TextEditingController();
  final jobCtrl = TextEditingController();
  final sapCtrl = TextEditingController();
  final roleCtrl = TextEditingController(text: "user");
  final activeCtrl = TextEditingController(text: "false");

  bool obsecurePass1 = true;
  bool obsecurePass2 = true;

// todo: handle functions

  void signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(AuthLoadingState());
      var either = await FirebaseUtils.getInstance()
          .signUpFirebase(getUserModel(context), context);
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

  String? nameFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (value.length < 3 && value.length > 20) {
      return "يجب ادخال الاسم بالكامل";
    } else if (value.isNumeric) {
      return "يجب ادخال الاسم بطريقة صحيحة";
    }
    return null;
  }

  String? passFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (value.length < 8 && value.length > 10) {
      return "يجب ادخال كلمة مرور مكونه من 8 على 10 حرف";
    } else if (passwordCtrl2.text != passwordCtrl1.text) {
      return "كلمة المرور غير متطابقة";
    }
    return null;
  }

  String? jobFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (value.length < 3 && value.length > 20 && value.isNumeric) {
      return "يجب ادخال الاسم بالكامل";
    }
    return null;
  }

  String? sapFieldValid(String? value) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (value.length < 3 && value.length > 5) {
      return "يجب ادخال رقم الساب بطريقة صحيحة";
    }
    return null;
  }

  MyUser getUserModel(BuildContext context) {
    MyUser userModel = MyUser(
      email: emailCtrl.text,
      password: passwordCtrl1.text,
      name: nameCtrl.text,
      job: jobCtrl.text,
      sap: sapCtrl.text,
      role: roleCtrl.text,
      active: activeCtrl.text == "true" ? true : false,
    );
    return userModel;
  }
}
