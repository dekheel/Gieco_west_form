import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/Cubit/login_screen_view_model.dart';
import 'package:gieco_west/UiLayer/AuthScreens/SignUpScreen/signup_screen.dart';
import 'package:gieco_west/UiLayer/AuthScreens/auth_states.dart';
import 'package:gieco_west/UiLayer/HomeScreen/home_screen.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "LoginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (viewModel.lastPressedAt == null ||
        now.difference(viewModel.lastPressedAt!) > const Duration(seconds: 2)) {
      // Show toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اضغط رجوع مرة أخرى للخروج',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      ); // Update the last pressed time
      viewModel.lastPressedAt = now;
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: viewModel
        ..getuserEmailPass()
        ..showPassword(),
      listener: (context, state) {
        if (state is AuthLoadingState) {
          EasyLoading.show(status: 'جاري التحميل.....');
        } else if (state is AuthErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is AuthSuccessState) {
          EasyLoading.dismiss();
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          EasyLoading.showInfo('تم تسجيل الدخول بنجاح.');
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: viewModel.canPop,
          onPopInvoked: (bool value) {
            setState(() {
              viewModel.canPop = !value;
            });

            if (viewModel.canPop) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("اضغط رجوع مرة أخرى لمسح البيانات والخروج"),
                  duration: Duration(milliseconds: 1500),
                ),
              );
            }
          },
          child: Scaffold(
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: MyColors.blueM3DarkPrimary.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.r)),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                height: 500.h,
                child: SingleChildScrollView(
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Const.splashLogo, height: 130.h),
                        Gap(25.h),
                        CustomTextFormField(
                          labelText: "البريد الالكتروني",
                          controller: viewModel.emailCtrl,
                          onChanged: (value) {
                            viewModel.emailCtrl.text = value;
                          },
                          validator: viewModel.emailFieldValid,
                          inputType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          suffixIcon: const Icon(
                            Icons.email,
                            color: MyColors.blueM3LightPrimary,
                          ),
                        ),
                        Gap(15.h),
                        CustomTextFormField(
                          obscureText: viewModel.obsecurePass,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state is HidePassState?
                                  ? Icons.visibility_off
                                  : state is ShowPassState
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                              color: MyColors.blueM3LightPrimary,
                            ),
                            color: MyColors.blueM3LightPrimary,
                            onPressed: () {
                              viewModel.obsecurePass = !viewModel.obsecurePass;
                              viewModel.showPassword();
                            },
                          ),
                          labelText: "كلمة المرور",
                          controller: viewModel.passwordCtrl,
                          onChanged: (value) {
                            viewModel.passwordCtrl.text = value;
                          },
                          validator: viewModel.passFieldValid,
                          inputType: TextInputType.visiblePassword,
                          textAlign: TextAlign.left,
                        ),
                        Gap(15.h),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.login(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 15.h),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 16.sp,
                                    color: MyColors.blueM3LightPrimary),
                          ),
                          child: const Text('تسجيل الدخول'),
                        ),
                        Gap(15.h),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Text(' لا تملك حساب؟ ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    color: MyColors.greyColor)),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        Gap(15.h),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpPage.routeName);
                          },
                          child: RichText(
                              text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'سجل الآن',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: MyColors.blueM3LightPrimary)),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
