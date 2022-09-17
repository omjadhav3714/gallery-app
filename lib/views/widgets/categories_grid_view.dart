import 'package:flutter/material.dart';

import '../utilities/category_grid_card_view.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({Key? key, required this.categoryCardsList}) : super(key: key);
  final List<CategoryGridCardView> categoryCardsList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 4/5,
      crossAxisCount: 3,
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 2.0,
      children: List.generate(categoryCardsList.length, (index) {
        return Center(
          child: categoryCardsList[index],
        );
      }),
    );
  }
}
