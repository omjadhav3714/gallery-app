import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../entities/User.dart';
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
}