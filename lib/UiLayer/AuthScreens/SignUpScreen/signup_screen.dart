import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/login_screen.dart';
import 'package:gieco_west/UiLayer/AuthScreens/SignUpScreen/Cubit/signup_screen_view_model.dart';
import 'package:gieco_west/UiLayer/AuthScreens/auth_states.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/widgets/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = "SignUpPage";

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpScreenViewModel viewModel = SignUpScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          EasyLoading.show(status: 'جاري التحميل.....');
        } else if (state is AuthErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is AuthSuccessState) {
          EasyLoading.dismiss();
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          EasyLoading.showInfo('تم التسجيل بنجاح.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("تسجيل مستخدم جديد"),
          backgroundColor: Colors.transparent,
        ),
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
            height: 750.h,
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Const.splashLogo, height: 130.h),
                    Gap(25.h),
                    CustomTextFormField(
                      labelText: "اسم المستخدم",
                      controller: viewModel.nameCtrl,
                      onChanged: (value) {
                        viewModel.nameCtrl.text = value;
                      },
                      validator: viewModel.nameFieldValid,
                      inputType: TextInputType.text,
                      textAlign: TextAlign.right,
                      suffixIcon: const Icon(
                        Icons.person_outline,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(15.h),
                    CustomTextFormField(
                      labelText: "الوظيفة",
                      controller: viewModel.jobCtrl,
                      onChanged: (value) {
                        viewModel.jobCtrl.text = value;
                      },
                      validator: viewModel.jobFieldValid,
                      inputType: TextInputType.text,
                      textAlign: TextAlign.right,
                      suffixIcon: const Icon(
                        Icons.work,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(15.h),
                    CustomTextFormField(
                      labelText: "رقم الساب",
                      controller: viewModel.sapCtrl,
                      onChanged: (value) {
                        viewModel.sapCtrl.text = value;
                      },
                      validator: viewModel.sapFieldValid,
                      inputType: TextInputType.number,
                      textAlign: TextAlign.left,
                      suffixIcon: const Icon(
                        Icons.numbers,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(15.h),
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
                      obscureText: viewModel.obsecurePass1,
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.obsecurePass1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: MyColors.blueM3LightPrimary,
                        ),
                        color: MyColors.blueM3LightPrimary,
                        onPressed: () {
                          viewModel.obsecurePass1 = !viewModel.obsecurePass1;
                          setState(() {});
                        },
                      ),
                      labelText: "كلمة المرور",
                      controller: viewModel.passwordCtrl1,
                      onChanged: (value) {
                        viewModel.passwordCtrl1.text = value;
                      },
                      validator: viewModel.passFieldValid,
                      inputType: TextInputType.visiblePassword,
                      textAlign: TextAlign.left,
                    ),
                    Gap(15.h),
                    CustomTextFormField(
                      obscureText: viewModel.obsecurePass2,
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.obsecurePass2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: MyColors.blueM3LightPrimary,
                        ),
                        color: MyColors.blueM3LightPrimary,
                        onPressed: () {
                          viewModel.obsecurePass2 = !viewModel.obsecurePass2;
                          setState(() {});
                        },
                      ),
                      labelText: "تأكيد كلمة المرور",
                      controller: viewModel.passwordCtrl2,
                      onChanged: (value) {
                        viewModel.passwordCtrl2.text = value;
                      },
                      validator: viewModel.passFieldValid,
                      inputType: TextInputType.visiblePassword,
                      textAlign: TextAlign.left,
                    ),
                    Gap(15.h),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.signUp(context);
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
                      child: const Text('تسجيل'),
                    ),
                    Gap(15.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
