import 'package:flutter/material.dart';
import '../models/authentication/AuthServiceModel.dart';

class AuthController {
  // Login user with Google
  Future<void> loginWithGoogle(BuildContext context) async {
    await AuthServiceModel().loginWithGoogle(context);
  }

  Future<void> logOutUser() async {
    await AuthServiceModel().signOutUser();
  }

  Future<void> loginWithEmailPassword(
      BuildContext context, String email, String password) async {
    await AuthServiceModel().loginWithEmailPassword(context, email, password);
  }

  Future<void> registerWithEmailPassword(BuildContext context, String email,
      String password, String name, String phone) async {
    await AuthServiceModel()
        .registerWithEmailPassword(context, email, password, name, phone);
  }
}
