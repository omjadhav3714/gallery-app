import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/views/category_pages/subcategory_view.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../utilities/bottom_navigation_bar.dart';
import '../utilities/category_grid_card_view.dart';
import '../widgets/appbar_view.dart';

class AllCategoriesGridView extends StatelessWidget {
  const AllCategoriesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriesStream = FirebaseFirestore.instance
        .collection('categories')
        .snapshots(includeMetadataChanges: true);

    return StreamBuilder<QuerySnapshot>(
      stream: categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(noData),
          );
        }
        return Scaffold(
          // endDrawer: const NavBarView(),
          bottomNavigationBar:
              const CustomBottomNavigationBar(selectedIndex: 1),
          appBar: AppBarView().getCustomAppBar(
            title: const Text(
              "Categories ",
              style: TextStyle(
                color: primaryColor,fontFamily: "Poppins", fontWeight: FontWeight.w600
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.count(
                  childAspectRatio: 4 / 5,
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    return Center(
                      child: CategoryGridCardView(
                        data: snapshot.data!.docs[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoryView(
                                category: snapshot.data!.docs[index]['name'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
