import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../entities/User.dart';
import '../user/UserHandlerModel.dart';
import 'FirebaseAuthServiceModel.dart';

class AuthServiceModel {
  Future<UserData?> loginWithGoogle(BuildContext context) async {
    final authServiceProvider =
        Provider.of<FirebaseAuthServiceModel>(context, listen: false);
    UserData? userModel = await authServiceProvider.signInWithGoogle(context);
    return userModel;
  }

  UserData? getCurrentUser(BuildContext context) {
    return Provider.of<UserData?>(context, listen: false);
  }

  Future<void> signOutUser() async {
    await FirebaseAuthServiceModel().signOutUser();
  }

  Future<UserData?> loginWithEmailPassword(
      BuildContext context, String email, String password) async {
    final authServiceProvider =
        Provider.of<FirebaseAuthServiceModel>(context, listen: false);
    UserData? userModel = await authServiceProvider.signInWithEmailPassword(
        context, email, password);
    return userModel;
  }

  Future<UserData?> registerWithEmailPassword(BuildContext context,
      String email, String password, String name, String phone) async {
    final authServiceProvider =
        Provider.of<FirebaseAuthServiceModel>(context, listen: false);
    UserData? userModel = await authServiceProvider.registerWithEmailPassword(
        context, email, password, name);
    if (userModel != null) {
      await UserHandlerModel().storeUserDetails(context, phone: phone);
    }
    // return userModel;
  }
}
