import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/Facebook.png",
            width: 80,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/Facebook.png",
            width: 80,
          ),
        ),
      ],
    );
  }
}
