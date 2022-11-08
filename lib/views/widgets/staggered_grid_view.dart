import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../utilities/staggered_grid_card_view.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({Key? key}) : super(key: key);
  // final List<StaggeredGridCardView> gridCardsList;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriesStream = FirebaseFirestore.instance
        .collection('templates')
        .where('category', isEqualTo: 'Festivals')
        .orderBy('created', descending: true)
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
          return StaggeredGrid.count(
            crossAxisCount: 5,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[0],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[1],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[2],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[3],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[4],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[5],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[6],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[7],
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredGridCardView(
                  data: snapshot.data!.docs[8],
                ),
              ),
            ],
          );
        });
  }
}
