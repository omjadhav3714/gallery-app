import 'package:flutter/material.dart';
import 'package:greetings_app/controllers/AuthController.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          // Trigger Google Sign in
          await AuthController().loginWithGoogle();
        },
        child: Image.asset(
          "assets/google_logo.png",
          width: 80,
        ),
      ),
    );
  }
}
