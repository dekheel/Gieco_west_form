import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gieco_west/Utils/colors.dart';

class CustomTextWgt extends StatelessWidget {
  const CustomTextWgt(
      {this.maxLines,
      this.fontSize,
      super.key,
      this.color,
      required this.data});

  final String data;
  final Color? color;
  final double? fontSize;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: color ?? MyColors.blackColor, fontSize: fontSize),
    );
  }
}
