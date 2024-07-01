import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const DrawerItem(
      {required this.onTap,
      required this.icon,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () {
        if (provider.currentUser!.active!) {
          // AdManager.loadInterstitialAd();
          onTap();
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يجب تفعيل الحساب رجاء الاتصال بمدير النظام"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Row(
        children: [
          Gap(
            10.w,
          ),
          Icon(
            icon,
            color: MyColors.blackColor,
            size: 35.sp,
          ),
          Gap(
            10.w,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyColors.blackColor,
                ),
          )
        ],
      ),
    );
  }
}
