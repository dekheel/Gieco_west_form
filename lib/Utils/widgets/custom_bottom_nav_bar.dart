import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';

class CustomBottomNavBar extends StatelessWidget {
  final BuildContext context;
  final int selectedIndex;
  final void Function(int)? onTap;

  const CustomBottomNavBar(
      {required this.context,
      required this.selectedIndex,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: MyColors.blueM3LightPrimary),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          iconSize: 10.spMin,
          currentIndex: selectedIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  foregroundColor: selectedIndex == 0
                      ? MyColors.blueM3LightPrimary
                      : MyColors.whiteColor,
                  backgroundColor: selectedIndex == 0
                      ? MyColors.whiteColor
                      : Colors.transparent,
                  radius: 20.r,
                  child: ImageIcon(
                    AssetImage(
                      selectedIndex == 0 ? Const.tripIcon : Const.shiftIcon,
                    ),
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  foregroundColor: selectedIndex == 1
                      ? MyColors.blueM3LightPrimary
                      : MyColors.whiteColor,
                  backgroundColor: selectedIndex == 1
                      ? MyColors.whiteColor
                      : Colors.transparent,
                  radius: 20.r,
                  child: ImageIcon(
                    AssetImage(
                      selectedIndex == 1 ? Const.tripIcon : Const.shiftIcon,
                    ),
                  ),
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
