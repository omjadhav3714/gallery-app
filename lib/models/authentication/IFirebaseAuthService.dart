import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/entities/User.dart';
import 'FirebaseAuthServiceModel.dart';

abstract class IFirebaseAuthServiceModel {
  FirebaseAuthServiceModel getCurrentInstance();
  User? getFirebaseUser();
  Stream<UserData?> onAuthStateChanged(BuildContext context);
  Future<UserData?> signInWithGoogle(BuildContext context);
  Future signOutUser();
  void dispose();
  Future<UserData?> signInWithEmailPassword(
      BuildContext context, String email, String password);
  Future<UserData?> registerWithEmailPassword(
      BuildContext context, String email, String password, String name);
}
