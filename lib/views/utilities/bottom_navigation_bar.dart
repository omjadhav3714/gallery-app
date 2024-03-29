import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:greetings_app/constants/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);
  final int selectedIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        gap: 8,
        color: Colors.grey[800],
        backgroundColor: white,
        activeColor: primaryColor,
        iconSize: 24,
        tabBackgroundColor: primaryColor.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        duration: const Duration(milliseconds: 500),
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.houseChimneyUser,
            text: 'Home',
            textStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
            textColor: primaryColor,
          ),
          GButton(
            icon: FontAwesomeIcons.boxesStacked,
            text: 'Categories',
             textStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
            textColor: primaryColor,
          ),
          GButton(
            icon: FontAwesomeIcons.wandSparkles,
            text: 'Explore',
             textStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
            textColor: primaryColor,
          ),
          GButton(
            icon: FontAwesomeIcons.user,
            text: 'My Profile',
             textStyle: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
            textColor: primaryColor,
          )
        ],
        selectedIndex: widget.selectedIndex,
        onTabChange: (index) async {
          if (index != widget.selectedIndex) {
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false);
            } else if (index == 1) {
               Navigator.pushNamedAndRemoveUntil(
                  context, "/allCategories", (route) => false);
            } else if (index == 2) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/explore", (route) => false);
            } else if (index == 3) {
                Navigator.pushNamedAndRemoveUntil(
                  context, "/userProfile", (route) => false);
            }
          }
        },
      ),
    );
  }
}
