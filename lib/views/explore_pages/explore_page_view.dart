import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../utilities/bottom_navigation_bar.dart';
import 'explore_templates.dart';

class ExplorePageView extends StatefulWidget {
  const ExplorePageView({Key? key}) : super(key: key);

  @override
  State<ExplorePageView> createState() => _ExplorePageViewState();
}

class _ExplorePageViewState extends State<ExplorePageView> {
  @override
  Widget build(BuildContext context) {
     final Stream<DocumentSnapshot> categoryStream = FirebaseFirestore.instance
        .collection('categories')
        .doc()
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<DocumentSnapshot>(
        stream: categoryStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text(wentWrong);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return DefaultTabController(
            length: 10,
            child: Scaffold(
              bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  "Explore",
                  style: TextStyle(
                    color: primaryColor,fontFamily: "Poppins", fontWeight: FontWeight.w600
                  ),
                ),
                backgroundColor: white,
               
              ),
              body: const ExploreTemplateView()
            ),
          );
        });
  }
}