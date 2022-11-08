import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StaggeredGridCardView extends StatelessWidget {
  const StaggeredGridCardView(
      {Key? key,required this.data})
      : super(key: key);
  final QueryDocumentSnapshot? data;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: GestureDetector(
        onTap: (){},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: data!['img'],
            placeholder: (context, url) => Shimmer.fromColors(
              period: const Duration(milliseconds:500),
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
