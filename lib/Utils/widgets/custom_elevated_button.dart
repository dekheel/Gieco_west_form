import 'package:flutter/material.dart';
import 'package:gieco_west/Utils/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {this.backGroundColor,
      this.titleColor,
      required this.title,
      required this.onPressed,
      super.key});
  final void Function()? onPressed;
  final String title;
  final Color? backGroundColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backGroundColor ?? MyColors.blueM3LightPrimary),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: titleColor ?? MyColors.whiteColor),
        ));
  }
}
