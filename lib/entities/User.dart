import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String? uid;
  String? email;
  String? photoUrl;
  String? displayName;

  UserData({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
  }) {
    notifyListeners();
  }

  void updateData({
    String? uid,
    String? email,
    String? photoUrl,
    String? displayName,
  }) {
    if (uid != null) {
      this.uid = uid;
    }
    if (email != null) {
      this.email = email;
    }
    if (photoUrl != null) {
      this.photoUrl = photoUrl;
    }
    if (displayName != null) {
      this.displayName = displayName;
    }
    notifyListeners();
  }

  void updateUserUsingObject(UserData user) {
    uid = user.uid;
    email = user.email;
    photoUrl = user.photoUrl;
    displayName = user.displayName;
    notifyListeners();
  }
}
