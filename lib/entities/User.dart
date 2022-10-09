import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String? uid;
  String? email;
  String? photoUrl;
  String? displayName;
  String? authStatusMessage;
  bool? loggedIn;

  UserData({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.authStatusMessage,
    this.loggedIn,
  }) {
    notifyListeners();
  }

  void updateData(
      {String? uid,
      String? email,
      String? photoUrl,
      String? displayName,
      String? authStatusMessage,
      bool? loggedIn}) {
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
    if (authStatusMessage != null) {
      this.authStatusMessage = authStatusMessage;
    }
    if (loggedIn != null) {
      this.loggedIn = loggedIn;
    }
    notifyListeners();
  }

  void updateUserUsingObject(UserData user) {
    uid = user.uid;
    email = user.email;
    photoUrl = user.photoUrl;
    displayName = user.displayName;
    authStatusMessage = user.authStatusMessage;
    loggedIn = user.loggedIn;
    notifyListeners();
  }
}
