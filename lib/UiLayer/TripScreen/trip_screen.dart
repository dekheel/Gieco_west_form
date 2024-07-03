import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/UiLayer/TripScreen/Cubit/trip_screen_view_model.dart';
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

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  static String routeName = "TripScreen";

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen>
    with AutomaticKeepAliveClientMixin<TripScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    viewModel.trainCapCtrl.addListener(viewModel.onTrainCapChanged);
    viewModel.trainCapAsstCtrl.addListener(viewModel.onTrainCapAsstChanged);
    viewModel.trainConductorCtrl.addListener(viewModel.onTrainConductorChanged);
  }

  @override
  void dispose() {
    viewModel.trainCapCtrl.removeListener(viewModel.onTrainCapChanged);
    viewModel.trainCapAsstCtrl.removeListener(viewModel.onTrainCapAsstChanged);
    viewModel.trainConductorCtrl
        .removeListener(viewModel.onTrainConductorChanged);

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

  TripScreenViewModel viewModel = TripScreenViewModel();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<TripScreenViewModel, ReportStates>(
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
            title: const Text("نموذج اضافة سفرية"),
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
                            visible: viewModel.currentStep == 5,
                            child: Expanded(
                                child: CustomElevatedButton(
                                    backGroundColor: MyColors.greenColor,
                                    title: "حفظ وارسال",
                                    onPressed: details.onStepContinue)),
                          ),
                          Visibility(
                            visible: viewModel.currentStep != 5,
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
                            posFunction: (context) {
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
                            if (viewModel.isFuel == false) {
                              viewModel.fuelInvoiceNoCtrl.text = "";
                              viewModel.fuelType = "";
                              viewModel.gazQtyCtrl.text = "";
                              viewModel.oilQtyCtrl.text = "";
                              viewModel.fuelInvoiceUrlCtrl.text = "";
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
            title: const Text('القطار'),
            state: viewModel.currentStep > 2
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 2,
            content: Form(
              key: viewModel.formKeys[2],
              child: Column(
                children: [
                  Gap(10.h),
                  CustomDropFormField(
                      onChanged: (value) {
                        viewModel.trainType = value;
                      },
                      labelText: 'نوع القطار',
                      listData: Const.trainTypeList),
                  Gap(10.h),
                  CustomDropFormField(
                      onChanged: (value) {
                        if (value != null && value == "فوارغ") {
                          setState(() {
                            viewModel.trainEmpty = "فوارغ";
                            viewModel.waybillNoCtrl.text = "";
                          });
                        } else {
                          setState(() {
                            viewModel.trainEmpty = "مشحون";
                          });
                        }
                        viewModel.trainState = value;
                      },
                      labelText: 'حالة القطار',
                      listData: Const.trainStateList),
                  Gap(10.h),
                  Visibility(
                      visible: viewModel.trainEmpty == "مشحون",
                      child: CustomTextFormField(
                        validator: viewModel.numberFieldValid,
                        labelText: "رقم البوليصة",
                        controller: viewModel.waybillNoCtrl,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                          viewModel.waybillNoCtrl.text = value;
                        },
                      )),
                  Gap(10.h),
                  CustomTextFormField(
                    validator: viewModel.textFieldValid,
                    labelText: "برسم",
                    controller: viewModel.tariffCtrl,
                    inputType: TextInputType.text,
                    onChanged: (value) {
                      viewModel.tariffCtrl.text = value;
                    },
                  ),
                  Gap(10.h),
                  CustomTextFormField(
                    validator: viewModel.numberFieldValid,
                    labelText: "عدد العربات",
                    controller: viewModel.coachQtyCtrl,
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      viewModel.coachQtyCtrl.text = value;
                    },
                  ),
                  Gap(10.h),
                  CustomTextFormField(
                    validator: viewModel.numberFieldValid,
                    labelText: "رقم أول عربة",
                    controller: viewModel.firstCoachNoCtrl,
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      viewModel.firstCoachNoCtrl.text = value;
                    },
                  ),
                  Gap(10.h),
                  CustomTextFormField(
                    validator: viewModel.numberFieldValid,
                    labelText: "رقم آخر عربة",
                    controller: viewModel.lastCoachNoCtrl,
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      viewModel.lastCoachNoCtrl.text = value;
                    },
                  ),
                  Gap(10.h),
                  CustomTextFormField(
                    validator: viewModel.numberFieldValid,
                    labelText: "رقم السبنسة",
                    controller: viewModel.sebensaNoCtrl,
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      viewModel.sebensaNoCtrl.text = value;
                    },
                  ),
                  Gap(10.h),
                  CustomTextFormField(
                    labelText: "أماكن التخزين",
                    controller: viewModel.tempStationCtrl,
                    inputType: TextInputType.text,
                    onChanged: (value) {
                      viewModel.tempStationCtrl.text = value;
                    },
                    maxLine: 4,
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWgt(data: "أمن القطار ؟"),
                      CupertinoSwitch(
                          // overrides the default green color of the track
                          activeColor: MyColors.greenColor,
                          // color of the round icon, which moves from right to left
                          thumbColor: MyColors.whiteColor,
                          // when the switch is off
                          trackColor: MyColors.blackColor,
                          // boolean variable value

                          value: viewModel.trainSecurity,
                          // changes the state of the switch
                          onChanged: (value) {
                            setState(() => viewModel.trainSecurity = value);
                          }),
                    ],
                  ),
                  Gap(10.h),
                ],
              ),
            )),
        Step(
            title: const Text('الرحلة'),
            state: viewModel.currentStep > 3
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 3,
            content: Form(
              key: viewModel.formKeys[3],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.h),
                    CustomDropFormField(
                        onChanged: (value) {
                          setState(() {
                            viewModel.tripTypeCtrl.text = value ?? "";

                            if (value == "وصول") {
                              viewModel.depStationCtrl.clear();
                              viewModel.depTimeCtrl.clear();
                              viewModel.nxtArrFromdepStationCtrl.clear();
                              viewModel.gazOnDepCtrl.clear();
                            } else if (value == "قيام") {
                              viewModel.arrTimeCtrl.clear();
                              viewModel.arrStationCtrl.clear();
                              viewModel.gazOnArrCtrl.clear();
                            }
                          });
                        },
                        labelText: 'نوع الرحلة',
                        listData: const ["قيام", "وصول"]),
                    Gap(10.h),
                    Visibility(
                        visible: viewModel.tripTypeCtrl.text == "قيام",
                        child: Column(
                          children: [
                            CustomTextFormField(
                              validator: viewModel.textFieldValid,
                              labelText: "محطة القيام",
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
                              labelText: "وقت القيام",
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
                              validator: viewModel.textFieldValid,
                              labelText: "محطة الوصول التالية",
                              controller: viewModel.nxtArrFromdepStationCtrl,
                              inputType: TextInputType.text,
                              onChanged: (value) {
                                viewModel.nxtArrFromdepStationCtrl.text = value;
                              },
                            ),
                            Gap(10.h),
                            CustomTextFormField(
                              validator: viewModel.numberFieldValid,
                              labelText: "كمية السولار عند القيام",
                              controller: viewModel.gazOnDepCtrl,
                              inputType: TextInputType.number,
                              onChanged: (value) {
                                viewModel.gazOnDepCtrl.text = value;
                              },
                            ),
                            Gap(10.h),
                          ],
                        )),
                    Visibility(
                        visible: viewModel.tripTypeCtrl.text == "وصول",
                        child: Column(
                          children: [
                            CustomTextFormField(
                              validator: viewModel.textFieldValid,
                              labelText: "محطة الوصول",
                              controller: viewModel.arrStationCtrl,
                              inputType: TextInputType.text,
                              onChanged: (value) {
                                viewModel.arrStationCtrl.text = value;
                              },
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
                              labelText: "وقت الوصول",
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
                              labelText: "كمية السولار عند الوصول",
                              controller: viewModel.gazOnArrCtrl,
                              inputType: TextInputType.number,
                              onChanged: (value) {
                                viewModel.gazOnArrCtrl.text = value;
                              },
                            ),
                            Gap(10.h),
                          ],
                        ))
                  ],
                ),
              ),
            )),
        Step(
            title: const Text('الخدمه'),
            state: viewModel.currentStep > 4
                ? StepState.complete
                : StepState.indexed,
            isActive: viewModel.currentStep >= 4,
            content: Form(
              key: viewModel.formKeys[4],
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
                              textAlign: TextAlign.left,
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
                              textAlign: TextAlign.left,
                              inputType: TextInputType.number,
                              validator: viewModel.sapFieldValid,
                              hintText: "الساب",
                              controller: viewModel.trainCapAsstSapCtrl),
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
                                viewModel.trainConductorCtrl.text =
                                    value!.trim();
                                viewModel.trainConductorSapCtrl.text =
                                    Const.trainConductor[value] ?? "";
                              },
                              label: 'مشرف القطار',
                              suggestion: Const.trainConductor.keys.toList(),
                              controller: viewModel.trainConductorCtrl),
                        ),
                        Gap(10.w),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: CustomTextFormField(
                              textAlign: TextAlign.left,
                              inputType: TextInputType.number,
                              validator: viewModel.sapFieldValid,
                              hintText: "الساب",
                              controller: viewModel.trainConductorSapCtrl),
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
            isActive: viewModel.currentStep >= 5,
            content: Form(
              key: viewModel.formKeys[5],
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
