import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/Drawer/drawer_item.dart';
import 'package:gieco_west/UiLayer/Reports/report_screen.dart';
import 'package:gieco_west/UiLayer/ShiftScreen/shift_screen.dart';
import 'package:gieco_west/UiLayer/TripScreen/trip_screen.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/widgets/user_info.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    var userProvider = Provider.of<UserProvider>(context);

    return SizedBox(
      width: screenSize.width * .75,
      child: SafeArea(
        child: NavigationDrawer(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              // height: ScreenSize.height * .12,
              color: MyColors.blueM3LightPrimary,
              child:
                  Center(child: UserInfo(userInfo: userProvider.currentUser)),
            ),
            Gap(
              20.h,
            ),
            DrawerItem(
              icon: Icons.home,
              title: "الصفحة الرئيسية",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Gap(
              20.h,
            ),
            DrawerItem(
              icon: Icons.train,
              title: "سفرية",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(TripScreen.routeName);
              },
            ),
            Gap(
              20.h,
            ),
            DrawerItem(
              icon: Icons.workspaces_sharp,
              title: "وردية",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ShiftScreen.routeName);
              },
            ),
            Gap(
              20.h,
            ),
            DrawerItem(
                icon: Icons.file_present,
                title: "تقارير",
                onTap: () async {
                  if (userProvider.currentUser?.role == "admin") {
                    // AdManager.loadRewardedAd();
                    Navigator.of(context).pop();

                    showMaterialModalBottomSheet(
                      bounce: true,
                      context: context,
                      builder: (context) => const ReportWidget(),
                    );
                  } else {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("ليس لديك صلاحية الاطلاع على التقارير")));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
