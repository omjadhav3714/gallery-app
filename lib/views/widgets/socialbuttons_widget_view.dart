import 'package:flutter/material.dart';
import 'package:greetings_app/controllers/AuthController.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            // Trigger Google Sign in
            await AuthController().loginWithGoogle(context);
          },
          child: Image.asset(
            "assets/google_logo.png",
            width: 80,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Image.asset(
          "assets/Facebook.png",
          width: 80,
        ),
      ],
    );
  }
}
