import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AppBarView {
  AppBar getCustomAppBar({required Widget title}) {
    return AppBar(
      centerTitle: false,
      title: title,
      iconTheme: const IconThemeData(color: primaryColor),
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
    );
  }
}
