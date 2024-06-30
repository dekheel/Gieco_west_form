import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({required this.userInfo, super.key});

  final MyUser? userInfo;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20.h),
        CustomTextWgt(
          data: userInfo?.name ?? "",
          color: MyColors.whiteColor,
        ),
        Gap(20.h),
        CustomTextWgt(
          data: userInfo?.job ?? "",
          color: MyColors.whiteColor,
          maxLines: 1,
        ),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextWgt(
              data: "رقم الساب",
              color: MyColors.whiteColor,
            ),
            CustomTextWgt(
              data: userInfo?.sap ?? "",
              color: MyColors.whiteColor,
            ),
          ],
        ),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextWgt(
              data: "نوع الحساب",
              color: MyColors.whiteColor,
            ),
            CustomTextWgt(
              data: userInfo?.role == "admin" ? "مدير النظام" : "مستخدم عادي",
              color: MyColors.whiteColor,
            ),
          ],
        ),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextWgt(
              data: "حالة الحساب",
              color: MyColors.whiteColor,
            ),
            CupertinoSwitch(
              // overrides the default green color of the track
              activeColor: MyColors.greenColor,
              // color of the round icon, which moves from right to left
              thumbColor: MyColors.whiteColor,
              // when the switch is off
              trackColor: MyColors.redColor,
              // boolean variable value
              value: userInfo?.active ?? false, onChanged: null,
              // changes the state of the switch
            ),
          ],
        ),
        Gap(20.h),
      ],
    );
  }
}
