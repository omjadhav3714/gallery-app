import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../entities/User.dart';
import '../user/UserHandlerModel.dart';
import 'IFirebaseAuthService.dart';
import 'package:provider/provider.dart';

class FirebaseAuthServiceModel implements IFirebaseAuthServiceModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    "email",
  ]);

  // UserModel is a custom Class which we made in user.dart
  // User is a firebase Auth class which comes inbuilt with firebase_auth package.
  UserData? _userFromFirebase(User? user, BuildContext context) {
    var userModel = Provider.of<UserData?>(context, listen: false);
    userModel?.updateData(
      uid: user!.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
    return userModel;
  }

  @override
  User? getFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  FirebaseAuthServiceModel getCurrentInstance() {
    return this;
  }

  @override
  Stream<UserData?> onAuthStateChanged(BuildContext context) {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => _userFromFirebase(user, context));
  }

  @override
  Future<UserData?> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user;

    if (authResult.additionalUserInfo!.isNewUser) {
      await UserHandlerModel().storeUserDetails(context);
    }

    return _userFromFirebase(user, context);
  }

  @override
  Future signOutUser() async {
    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}
}
