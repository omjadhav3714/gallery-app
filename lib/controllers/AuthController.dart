import 'package:flutter/material.dart';
import '../models/authentication/AuthServiceModel.dart';

class AuthController {
  // Login user with Google
  Future<void> loginWithGoogle(BuildContext context) async {
    await AuthServiceModel().loginWithGoogle(context);
  }

  Future<void> logOutUser() async{
    await AuthServiceModel().signOutUser();
  }
  // void updateUserData(BuildContext context, bool isContentCreator) {
  //   // Update the UserModel with the usertype data
  //   AuthServiceModel().updateUserData(context, isContentCreator);
  // }
}
