import 'package:firebase_auth/firebase_auth.dart';
import 'package:greetings_app/entities/User.dart';
import 'FirebaseAuthServiceModel.dart';

abstract class IFirebaseAuthServiceModel {
  FirebaseAuthServiceModel getCurrentInstance();
  User? getFirebaseUser();
  Stream<UserData?> onAuthStateChanged();
  Future<UserData?> signInWithGoogle();
  Future signOutUser();
  void dispose();
  Future<UserData?> signInWithEmailPassword(
    String email,
    String password,
  );
  Future<UserData?> registerWithEmailPassword(
    String email,
    String password,
    String name,
    String phone,
  );
}
