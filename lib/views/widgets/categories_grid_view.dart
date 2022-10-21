import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/views/category_pages/subcategory_view.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../utilities/category_grid_card_view.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({Key? key}) : super(key: key);

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
        return GridView.count(
          childAspectRatio: 4 / 5,
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          children: List.generate(4, (index) {
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
        );
      },
    );
  }
}
