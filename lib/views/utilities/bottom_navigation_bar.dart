import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/models/authentication/FirebaseAuthServiceModel.dart';
import 'package:provider/provider.dart';

import '../category_pages/subcategory_view.dart';

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
        duration: const Duration(milliseconds: 1000),
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.houseChimneyUser,
            text: 'Home',
          ),
          GButton(
            icon: FontAwesomeIcons.boxesStacked,
            text: 'Festivals',
          ),
          GButton(
            icon: FontAwesomeIcons.user,
            text: 'Search',
          ),
          GButton(
            icon: FontAwesomeIcons.rightFromBracket,
            text: 'LogOut',
          )
        ],
        selectedIndex: widget.selectedIndex,
        onTabChange: (index) async {
          if (index != widget.selectedIndex) {
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false);
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubCategoryView(
                    category: "Festivals",
                  ),
                ),
              );
            } else if (index == 2) {
              Navigator.pushNamed(context, "/userProfile");
            } else if (index == 3) {
              await Provider.of<FirebaseAuthServiceModel>(context,
                      listen: false)
                  .signOutUser();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              }
            }
          }
        },
      ),
    );
  }
}
