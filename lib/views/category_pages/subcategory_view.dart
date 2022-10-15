// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/views/utilities/bottom_navigation_bar.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../widgets/backbutton_widget_view.dart';
import 'template_view.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.category)
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<DocumentSnapshot>(
        stream: _categoryStream,
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
              bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
              appBar: AppBar(
                leading: const BackButtonWidget(),
                elevation: 0,
                title: Text(
                  widget.category,
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                ),
                backgroundColor: white,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: primaryColor,
                  indicatorWeight: 4,
                  tabs: List.generate(
                    snapshot.data!['sub_category'].length,
                    (index) => Tab(
                      child: Text(
                        snapshot.data!['sub_category'][index]['text'],
                        style: const TextStyle(color: black),
                      ),
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: List.generate(
                  snapshot.data!['sub_category'].length,
                  (index) => TemplateView(
                    cat: widget.category,
                    subCat: snapshot.data!['sub_category'][index]['text'],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
