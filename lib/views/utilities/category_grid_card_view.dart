import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryGridCardView extends StatelessWidget {
  const CategoryGridCardView({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);
  final QueryDocumentSnapshot? data;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 5,
            shape: const CircleBorder(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: CachedNetworkImage(
                width: 100,
                height: 100,
                imageUrl: data!["img"],
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.225,
                    height: MediaQuery.of(context).size.width * 0.225,
                    child: Shimmer.fromColors(
                      period: const Duration(milliseconds: 500),
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Text(data!['name'], style: const TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500), ),
      ]),
    );
  }
}
