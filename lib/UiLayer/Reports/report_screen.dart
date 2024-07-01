import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/UiLayer/Reports/Cubits/report_screen_view_model.dart';
import 'package:gieco_west/UiLayer/Reports/report_states.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:gieco_west/Utils/widgets/custom_drop_form_field.dart';
import 'package:gieco_west/Utils/widgets/custom_text_form_field.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  ReportScreenViewModel viewModel = ReportScreenViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ReportScreenViewModel, CreateReportStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is CreateReportLoadingState) {
          EasyLoading.show(status: 'جاري التحميل.....');
        } else if (state is CreateReportErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is CreateReportSuccessState) {
          EasyLoading.dismiss();
          Navigator.of(context).pop();
          EasyLoading.showInfo('تم تحميل التقرير بنجاح.');
        }
      },
      child: SizedBox(
        height: size.height * .40,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blueM3LightPrimary,
            title: Text(
              'استخراج تقرير',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: MyColors.whiteColor),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: MyColors.whiteColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.h),
                    CustomDropFormField(
                        onChanged: (value) {
                          viewModel.reportTypeCtrl.text = value ?? "";
                        },
                        labelText: 'نوع التقرير',
                        listData: const ["سفرية", "وردية"]),
                    Gap(10.h),
                    CustomTextFormField(
                      onTap: () async {
                        var selectedDate =
                            await MyFunctions.selectDate(context);
                        if (selectedDate != null) {
                          viewModel.reportDateCtrl.text =
                              MyFunctions.formatDateString(selectedDate);
                        }
                      },
                      validator: viewModel.dateFieldValid,
                      labelText: "تاريخ التقرير",
                      isReadOnly: true,
                      controller: viewModel.reportDateCtrl,
                      inputType: TextInputType.datetime,
                      suffixIcon: const Icon(
                        Icons.date_range,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(10.h),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.createReport();
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: MyColors.blueM3DarkSecondaryContainer,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 15.h),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                                fontSize: 16.sp,
                                color: MyColors.blueM3LightPrimary),
                      ),
                      child: const Text('تحميل التقرير'),
                    ),
                    Gap(10.h)
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
