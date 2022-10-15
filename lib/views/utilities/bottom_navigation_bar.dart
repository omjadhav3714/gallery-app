import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:greetings_app/constants/colors.dart';

import '../category_pages/subcategory_view.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GNav(
          gap: 8,
          color: Colors.grey[800],
          activeColor: primaryColor,
          iconSize: 24,
          tabBackgroundColor: primaryColor.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          duration: const Duration(milliseconds: 1000),
          tabs: const [
            GButton(
              icon:  CarbonIcons.home,
              text: 'Home',
            ),
            GButton(
              icon:  CarbonIcons.shape_exclude,
              text: 'Festivals',
            ),
            GButton(
              icon:  CarbonIcons.home,
              text: 'Search',
            ),
            GButton(
              icon:  CarbonIcons.home,
              text: 'Profile',
            )
          ],
        selectedIndex: selectedIndex,
        onTabChange: (index) {
          if(index == 0){
            Navigator.pushNamed(context, "/home");
          }
          else if(index == 1){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubCategoryView(
                  category: "Festivals",
                ),
              ),
            );
          }
          else if(index == 2){
            Navigator.pushNamed(context, "/home");
          }
          else if(index == 3){
            Navigator.pushNamed(context, "/home");
          }
        },
      ),
    );
  }
}
