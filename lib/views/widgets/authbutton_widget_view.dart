import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AuthButtonWidget extends StatefulWidget {
  final String? btnTxt;
  final void Function()? onPress;
  const AuthButtonWidget({Key? key, this.btnTxt, this.onPress})
      : super(key: key);

  @override
  State<AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<AuthButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress ?? () {},
      style: ElevatedButton.styleFrom(
          primary: Colors.purpleAccent,
          elevation: 18,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            widget.btnTxt ?? "",
            style: const TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
