import 'package:flutter/material.dart';

String defaultProfileImageURL =
    "https://firebasestorage.googleapis.com/v0/b/gallery-app-41f69.appspot.com/o/users_profile_images%2Fdefault_user_avatar.png?alt=media&token=deb66487-b983-47cc-999e-9d1278ea7ff9";

Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;

IconData twitter = const IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = const IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus = const IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = const IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

const kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration =
    BoxDecoration(shape: BoxShape.circle, color: kAppPrimaryColor, boxShadow: [
  BoxShadow(
    color: kWhite,
    offset: const Offset(10, 10),
    blurRadius: 10,
  ),
  BoxShadow(
    color: kWhite,
    offset: const Offset(-10, -10),
    blurRadius: 10,
  ),
]);
