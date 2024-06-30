import 'package:flutter/material.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class CustomDropFormField extends StatelessWidget {
  const CustomDropFormField(
      {required this.onChanged,
      required this.labelText,
      required this.listData,
      this.fontSize,
      super.key});

  final List<String> listData;
  final String labelText;
  final void Function(String?)? onChanged;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: false,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: [
        for (var fuelType in listData)
          DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: fuelType,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CustomTextWgt(
                  data: fuelType,
                  fontSize: fontSize,
                )
              ]))
      ],
      onChanged: onChanged,
    );
  }
}
