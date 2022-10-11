import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';

class TextFieldView extends StatelessWidget {
  final TextEditingController controller;
  final String? labelTxt;
  final String? placeholderTxt;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  const TextFieldView(
      {Key? key,
      required this.controller,
      this.labelTxt,
      this.placeholderTxt,
      this.textInputType,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: Text(
            labelTxt ?? "",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
                width: 1,
              ),
            ),
            color: transparent,
          ),
          child: Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              maxLines: 1,
              keyboardType: textInputType ?? TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  placeholderTxt ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                border: InputBorder.none,
                floatingLabelStyle: const TextStyle(
                  color: black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
