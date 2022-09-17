import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';

class TextFieldView extends StatefulWidget {
  final TextEditingController? ctrl;
  final String? labelTxt;
  final String? placeholderTxt;
  final TextInputType? textInputType;
  const TextFieldView({Key? key, this.ctrl, this.labelTxt, this.placeholderTxt, this.textInputType})
      : super(key: key);

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
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
            widget.labelTxt ?? "",
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
              maxLines: 1,
              keyboardType: widget.textInputType ?? TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  widget.placeholderTxt ?? "",
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
