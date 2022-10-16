import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class RoundEdgeFilledButton extends StatelessWidget {
  const RoundEdgeFilledButton(
      {Key? key, required this.buttonText, this.onPressed})
      : super(key: key);

  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // backgroundColor: Colors.purpleAccent,
        elevation: 18,
        padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
      ),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            color: white,
          ),
        ),
      ),
    );
  }
}
