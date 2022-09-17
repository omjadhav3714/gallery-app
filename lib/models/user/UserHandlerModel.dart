import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../entities/User.dart';

class UserHandlerModel {
  final CollectionReference users =
  FirebaseFirestore.instance.collection("Users");

  /// Checks if the user exists and returns the data filled [UserData] instance or else null
  // Future<UserData?> tryToGetUserDetails(BuildContext context) async {
  //   var user = Provider.of<UserData?>(context);
  //   debugPrint(user!.email);
  //   var userDoc = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(user.email)
  //       .get();
  //   debugPrint(userDoc.data().toString());
  //   var data = userDoc.data();
  //   if (data != null) {
  //     user.updateData(
  //       uid: data["uid"],
  //       email: data["email"],
  //       isContentCreator: data["isContentCreator"],
  //       isNewUser: false,
  //       displayName: data["displayName"],
  //       accessToken: data["accessToken"],
  //     );
  //     return user;
  //   }
  //   return null;
  // }

  /// Creates a document in database with the user data
  Future<void> storeUserDetails(BuildContext context) async {
    var user = Provider.of<UserData?>(context, listen: false);
    return await users.doc(user!.email).set({
      "uid": user.uid,
      "email": user.email,
      "name": user.displayName,
      "photoUrl": user.photoUrl,
      "signUpTime": FieldValue.serverTimestamp(),
    }).catchError((error) =>
        debugPrint("Failed to add user details to database: $error"));
  }

  // Future<void> updateSingleUserDetail(BuildContext context, {required String key, required dynamic value}){
  //   var user = Provider.of<UserData?>(context, listen: false);
  //   return users.doc(user!.email).update({
  //     key : value
  //   }).catchError((error) =>
  //       debugPrint("Failed to update user details to database: $error"));
  // }
}
