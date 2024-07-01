import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/UiLayer/ShiftScreen/Cubit/shift_screen_view_model.dart';
import 'package:gieco_west/UiLayer/TripScreen/report_states.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/dialog_utils.dart';
import 'package:gieco_west/Utils/my_functions.dart';
import 'package:gieco_west/Utils/widgets/custom_drop_form_field.dart';
import 'package:gieco_west/Utils/widgets/custom_elevated_button.dart';
import 'package:gieco_west/Utils/widgets/custom_text_form_field.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';
import 'package:gieco_west/Utils/widgets/custom_type_ahead_form_field.dart';
import 'package:gieco_west/Utils/widgets/my_image_picker.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  static String routeName = "ShiftScreen";

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen>
    with AutomaticKeepAliveClientMixin<ShiftScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    viewModel.trainCapCtrl.addListener(viewModel.onTrainCapChanged);
    viewModel.trainCapAsstCtrl.addListener(viewModel.onTrainCapAsstChanged);
  }

  @override
  void dispose() {
    viewModel.trainCapCtrl.removeListener(viewModel.onTrainCapChanged);
    viewModel.trainCapAsstCtrl.removeListener(viewModel.onTrainCapAsstChanged);

    super.dispose();
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (viewModel.lastPressedAt == null ||
        now.difference(viewModel.lastPressedAt!) > const Duration(seconds: 2)) {
      // Show toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اضغط رجوع مرة أخرى لمسح البيانات والخروج',
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

  ShiftScreenViewModel viewModel = ShiftScreenViewModel();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ShiftScreenViewModel, ReportStates>(
      bloc: viewModel..getMyUser(context),
      listener: (context, state) {
        if (state is ReportLoadingState || state is UploadImageLoadingState) {
          EasyLoading.show(status: 'جاري التحميل.....');
        } else if (state is ReportErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is UploadImageErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is ReportSuccessState) {
          EasyLoading.dismiss();
          EasyLoading.showInfo('تم حفظ البيانات بنجاح.');
        } else if (state is UploadImageSuccessState) {
          EasyLoading.dismiss();
          EasyLoading.showInfo('تم حفظ صورة بون التموين بنجاح.');
        }
      },
      builder: (context, state) => PopScope(
        canPop: viewModel.canPop,
        onPopInvoked: (bool value) {
          setState(() {
            viewModel.canPop = !value;
          });
          if (value) {
            viewModel.resetForm();
          }
          if (viewModel.canPop) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("اضغط رجوع مرة أخرى للخروج"),
                duration: Duration(milliseconds: 1500),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("نموذج اضافة وردية"),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  tooltip: "مسح النموذج",
                  onPressed: () {
                    DialogUtils.showMessage(
                        context: context,
                        content: "تأكيد مسح البيانات ؟",
                        isDismissible: false,
                        posActions: "نعم",
                        negActions: "لا",
                        title: "مسح",
                        negFunction: (context) {
                          Navigator.of(context).pop();
                        },
                        posFunction: (context) {
                          Navigator.of(context).pop();
                          viewModel.resetForm();
                          viewModel.formKey.currentState?.reset();
                        });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: MyColors.blueM3LightPrimary,
                  ))
            ],
          ),
          body: Form(
            key: viewModel.formKey,
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                      primary: MyColors.blueM3DarkPrimaryContainer)),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Const.scaffoldImage),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.05),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
                Stepper(
                  physics: const BouncingScrollPhysics(),
                  controlsBuilder: (context, ControlsDetails details) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: viewModel.currentStep == 4,
                            child: Expanded(
                                child: CustomElevatedButton(
                                    backGroundColor: MyColors.greenColor,
                                    title: "حفظ وارسال",
                                    onPressed: details.onStepContinue)),
                          ),
                          Visibility(
                            visible: viewModel.currentStep != 4,
                            child: Expanded(
                                child: CustomElevatedButton(
                                    title: "التالي",
                                    onPressed: details.onStepContinue)),
                          ),
                          Gap(10.w),
                          Visibility(
                            visible: viewModel.currentStep != 0,
                            child: Expanded(
                                child: CustomElevatedButton(
                                    backGroundColor: MyColors.redColor,
                                    title: "الغاء",
                                    onPressed: details.onStepCancel)),
                          )
                        ],
                      ),
                    );
                  },
                  steps: getSteps(),
                  type: StepperType.vertical,
                  currentStep: viewModel.currentStep,
                  onStepContinue: () {
                    final isLastStep =
                        viewModel.currentStep == getSteps().length - 1;
                    if (viewModel.formKeys[viewModel.currentStep].currentState!
                        .validate()) {
                      if (isLastStep) {
                        DialogUtils.showMessage(
                            context: context,
                            content: "تأكيد حفظ وإرسال البيانات ؟",
                            isDismissible: false,
                            posActions: "نعم",
                            negActions: "لا",
                            title: "حفظ",
                            negFunction: (context) {
                              Navigator.of(context).pop();
                            },
                            posFunction: (context) async {
                              viewModel.getReportModel(context);
                              viewModel.addReport(context);
                              Navigator.of(context).pop();
                            });
                        setState(() {
                          viewModel.isCompleted = true;
                        });
                      } else {
                        setState(() {
                          viewModel.currentStep += 1;
                        });
                      }
                    }
                  },
                  onStepCancel: () {
                    if (viewModel.currentStep == 0) {
                      null;
                    } else {
                      setState(() {
                        viewModel.currentStep -= 1;
                      });
                    }
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  //  This will be your screens
  List<Step> getSteps() => [
        Step(
            title: const Text('بيانات أساسية'),
            state: viewModel.currentStep > 0
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 0,
            content: Form(
              key: viewModel.formKeys[0],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.h),
                    CustomTextFormField(
                      validator: viewModel.numberFieldValid,
                      labelText: "رقم الجرار",
                      controller: viewModel.locoNoCtrl,
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        viewModel.locoNoCtrl.text = value;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      onTap: () async {
                        var selectedDate =
                            await MyFunctions.selectDate(context);
                        if (selectedDate != null) {
                          viewModel.locoDateCtrl.text =
                              MyFunctions.formatDateString(selectedDate);
                        }
                      },
                      validator: viewModel.dateFieldValid,
                      labelText: "تاريخ السفرية",
                      isReadOnly: true,
                      controller: viewModel.locoDateCtrl,
                      inputType: TextInputType.datetime,
                      suffixIcon: const Icon(
                        Icons.date_range,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      labelText: "ملاحظات القائد على الجرار",
                      controller: viewModel.locoCapNotesCtrl,
                      inputType: TextInputType.text,
                      onChanged: (value) {
                        viewModel.locoCapNotesCtrl.text = value;
                      },
                      maxLine: 4,
                      validator: viewModel.textFieldValid,
                    )
                  ],
                ),
              ),
            )),
        Step(
            title: const Text('التموين'),
            state: viewModel.currentStep > 1
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 1,
            content: Form(
              key: viewModel.formKeys[1],
              child: Column(
                children: [
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWgt(data: "هل تم التموين ؟"),
                      CupertinoSwitch(
                          // overrides the default green color of the track
                          activeColor: MyColors.greenColor,
                          // color of the round icon, which moves from right to left
                          thumbColor: MyColors.whiteColor,
                          // when the switch is off
                          trackColor: MyColors.blackColor,
                          // boolean variable value
                          value: viewModel.isFuel,
                          // changes the state of the switch
                          onChanged: (value) {
                            if (value == false) {
                              viewModel.fuelInvoiceNoCtrl.clear();
                              viewModel.fuelType = null;
                              viewModel.gazQtyCtrl.clear();
                              viewModel.oilQtyCtrl.clear();
                              viewModel.fuelInvoiceUrlCtrl.clear();
                              viewModel.pickedImage = null;
                            }
                            setState(() => viewModel.isFuel = value);
                          }),
                    ],
                  ),
                  Gap(10.h),
                  Visibility(
                    visible: viewModel.isFuel,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          validator: viewModel.numberFieldValid,
                          labelText: "رقم بون التموين",
                          controller: viewModel.fuelInvoiceNoCtrl,
                          inputType: TextInputType.number,
                          onChanged: (value) async {
                            viewModel.fuelInvoiceNoCtrl.text = value;
                            if (viewModel.pickedImage != null) {
                              viewModel.uploadImage(
                                context,
                                viewModel.pickedImage!,
                                viewModel.fuelInvoiceNoCtrl.text,
                              );
                            }
                          },
                        ),
                        Gap(10.h),
                        CustomDropFormField(
                            onChanged: (value) {
                              viewModel.fuelType = value ?? "";
                            },
                            labelText: 'نوع التموين',
                            listData: Const.fuelTypeList),
                        Gap(10.h),
                        CustomTextFormField(
                          validator: viewModel.numberFieldValid,
                          labelText: "كمية السولار المنصرفة",
                          controller: viewModel.gazQtyCtrl,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.gazQtyCtrl.text = value;
                          },
                        ),
                        Gap(10.h),
                        CustomTextFormField(
                          validator: viewModel.numberFieldValid,
                          labelText: "كمية الزيت المنصرفة",
                          controller: viewModel.oilQtyCtrl,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.oilQtyCtrl.text = value;
                          },
                        ),
                        Gap(10.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CustomTextWgt(
                                data: "صورة بون التموين إن أمكن."),
                            Gap(10.h),
                            MyImagePicker(
                              onPickImage: (pickedImage) async {
                                if (viewModel
                                    .fuelInvoiceNoCtrl.text.isNotEmpty) {
                                  viewModel.pickedImage = pickedImage;
                                  viewModel.uploadImage(
                                    context,
                                    viewModel.pickedImage!,
                                    viewModel.fuelInvoiceNoCtrl.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Gap(10.h),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        Step(
            title: const Text('الوردية'),
            state: viewModel.currentStep > 2
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 2,
            content: Form(
              key: viewModel.formKeys[2],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.h),
                    CustomDropFormField(
                        onChanged: (value) {
                          viewModel.shiftTypeCtrl.text = value ?? "";
                        },
                        labelText: 'نوع الوردية',
                        listData: const ["شحن", "تفريغ", "تجهيز"]),
                    Gap(10.h),
                    CustomTextFormField(
                      validator: viewModel.textFieldValid,
                      labelText: "محطة بداية الوردية",
                      controller: viewModel.depStationCtrl,
                      inputType: TextInputType.text,
                      onChanged: (value) {
                        viewModel.depStationCtrl.text = value;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      onTap: () async {
                        var selectedTime = await MyFunctions.selectTime(
                            context, viewModel.locoDateCtrl.text);
                        if (selectedTime != null) {
                          viewModel.depTimeCtrl.text = selectedTime;
                        }
                      },
                      validator: viewModel.commonFieldValid,
                      labelText: "ساعة بداية الوردية",
                      isReadOnly: true,
                      controller: viewModel.depTimeCtrl,
                      inputType: TextInputType.datetime,
                      suffixIcon: const Icon(
                        Icons.access_time_rounded,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      validator: viewModel.numberFieldValid,
                      labelText: "كمية السولار عند بدء الوردية",
                      controller: viewModel.gazOnDepCtrl,
                      inputType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      onTap: () async {
                        var selectedTime = await MyFunctions.selectTime(
                            context, viewModel.locoDateCtrl.text);
                        if (selectedTime != null) {
                          viewModel.arrTimeCtrl.text = selectedTime;
                        }
                      },
                      validator: viewModel.commonFieldValid,
                      labelText: "ساعة نهاية الوردية",
                      isReadOnly: true,
                      controller: viewModel.arrTimeCtrl,
                      inputType: TextInputType.datetime,
                      suffixIcon: const Icon(
                        Icons.access_time_rounded,
                        color: MyColors.blueM3LightPrimary,
                      ),
                    ),
                    Gap(10.h),
                    CustomTextFormField(
                      validator: viewModel.numberFieldValid,
                      labelText: "كمية السولار عند نهاية الوردية",
                      controller: viewModel.gazOnArrCtrl,
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        viewModel.gazOnArrCtrl.text = value;
                      },
                    ),
                    Gap(10.h),
                  ],
                ),
              ),
            )),
        Step(
            title: const Text('الخدمه'),
            state: viewModel.currentStep > 3
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 3,
            content: Form(
              key: viewModel.formKeys[3],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTypeAheadFormField(
                              validators: viewModel.textFieldValid,
                              textInput: TextInputType.text,
                              onSuggestionSelected: (value) {
                                viewModel.trainCapCtrl.text = value!.trim();
                                viewModel.trainCapSapCtrl.text =
                                    Const.trainCap[value] ?? "";
                              },
                              label: 'قائد القطار',
                              suggestion: Const.trainCap.keys.toList(),
                              controller: viewModel.trainCapCtrl),
                        ),
                        Gap(10.w),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: CustomTextFormField(
                              inputType: TextInputType.number,
                              validator: viewModel.sapFieldValid,
                              hintText: "الساب",
                              controller: viewModel.trainCapSapCtrl),
                        )
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTypeAheadFormField(
                              validators: viewModel.textFieldValid,
                              textInput: TextInputType.text,
                              onSuggestionSelected: (value) {
                                viewModel.trainCapAsstCtrl.text = value!.trim();
                                viewModel.trainCapAsstSapCtrl.text =
                                    Const.trainCap[value] ?? "";
                              },
                              label: 'مساعد قائد القطار',
                              suggestion: Const.trainCap.keys.toList(),
                              controller: viewModel.trainCapAsstCtrl),
                        ),
                        Gap(10.w),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: CustomTextFormField(
                              inputType: TextInputType.number,
                              validator: viewModel.sapFieldValid,
                              hintText: "الساب",
                              controller: viewModel.trainCapAsstSapCtrl),
                        )
                      ],
                    ),
                    Gap(10.h),
                  ],
                ),
              ),
            )),
        Step(
            title: const Text('ملاحظات'),
            state: viewModel.currentStep > 4
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 4,
            content: Form(
              key: viewModel.formKeys[4],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.h),
                    CustomTextFormField(
                      labelText: "ملاحظات",
                      controller: viewModel.globalNoteCtrl,
                      inputType: TextInputType.text,
                      action: TextInputAction.done,
                      onChanged: (value) {
                        viewModel.globalNoteCtrl.text = value;
                      },
                      maxLine: 4,
                    )
                  ],
                ),
              ),
            )),
      ];
}
