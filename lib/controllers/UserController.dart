import 'package:flutter/material.dart';

import '../entities/User.dart';
import '../models/authentication/AuthServiceModel.dart';
import '../models/user/UserHandlerModel.dart';

class UserController {

  /// Returns a [UserData] instance filled with User's auth details
  UserData getUserData(BuildContext context) {
    return AuthServiceModel().getCurrentUser(context)!;
  }

}
