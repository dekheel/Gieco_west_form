import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class CustomTypeAheadFormField extends StatelessWidget {
  const CustomTypeAheadFormField(
      {super.key,
      this.label,
      required this.onSuggestionSelected,
      required this.suggestion,
      this.validators,
      this.textInput,
      required this.controller});

  final TextEditingController controller;
  final String? label;
  final List<String> suggestion;
  final void Function(String?) onSuggestionSelected;
  final String? Function(String?)? validators;
  final TextInputType? textInput;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String?>(
        validator: validators,
        textFieldConfiguration: TextFieldConfiguration(
            keyboardType: textInput ?? TextInputType.number,
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: false,
              hintText: label,
            )),
        hideKeyboardOnDrag: true,
        suggestionsBoxVerticalOffset: 10.0,
        suggestionsBoxController: SuggestionsBoxController(),
        keepSuggestionsOnSuggestionSelected: false,
        hideOnLoading: false,
        hideOnEmpty: true,
        hideOnError: true,
        hideSuggestionsOnKeyboardHide: false,
        suggestionsCallback: (value) {
          return suggestion
              .where((element) =>
                  element.toLowerCase().contains(value.toLowerCase()))
              .toList();
          // }
        },
        noItemsFoundBuilder: (context) => const SizedBox(
              height: 50,
              child: Center(
                child: Text('هذا الاسم غير موجود بقواعد البيانات'),
              ),
            ),
        // const Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Text('هذا الاسم غير موجود بقواعد البيانات'),
        //     ),
        suggestionsBoxDecoration: const SuggestionsBoxDecoration(
            color: Colors.white,
            elevation: 4.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        // suggestionsBoxDecoration: SuggestionsBoxDecoration(
        //   borderRadius: BorderRadius.circular(8.0),
        //   elevation: 0,
        // ),
        debounceDuration: const Duration(milliseconds: 400),

        // Widget to build each suggestion in the list
        itemBuilder: (context, String? text) {
          // return Row(
          //   children: [
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     const Icon(
          //       Icons.refresh,
          //       color: Colors.grey,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Flexible(
          //       child: Padding(
          //         padding: const EdgeInsets.all(6.0),
          //         child: Text(
          //           text ?? '',
          //           maxLines: 1,
          //           // style: TextStyle(color: Colors.red),
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //     )
          //   ],
          // );

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CustomTextWgt(
              data: text ?? "",
            ),
          );
        }, // Callback when a suggestion is selected

        onSuggestionSelected: onSuggestionSelected);
  }
}
