import 'package:flutter/material.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/TripScreen/trip_screen.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/custom_navigation.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({required this.routeName, super.key});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        if (provider.currentUser!.active!) {
          // AdManager.loadInterstitialAd();

          MyNavigation.getInstance().pushNamed(context, routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يجب تفعيل الحساب رجاء الاتصال بمدير النظام"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextWgt(
            data: routeName == TripScreen.routeName
                ? "إضافة سفرية"
                : "إضافة وردية",
            fontSize: 40,
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 50,
            child: Image.asset(routeName == TripScreen.routeName
                ? Const.tripIcon
                : Const.shiftIcon),
          )
        ],
      ),
    );
  }
}
