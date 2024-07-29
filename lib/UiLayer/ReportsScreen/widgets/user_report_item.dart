import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/UiLayer/ReportsScreen/view_report.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class UserReportItem extends StatelessWidget {
  UserReportItem({super.key, required this.data});
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ViewReport.routeName, arguments: data);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: MyColors.blueM3LightPrimary.withOpacity(.10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWgt(data: data.generalReportData!.locoNo!),
              const Icon(Icons.visibility_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
