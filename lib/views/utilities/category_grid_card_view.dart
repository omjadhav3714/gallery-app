import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class CategoryGridCardView extends StatelessWidget {
  const CategoryGridCardView(
      {Key? key,
      required this.networkImageUrl,
      this.onTap,
      required this.categoryType})
      : super(key: key);
  final String networkImageUrl;
  final Function()? onTap;
  final String categoryType;
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
                imageUrl: networkImageUrl,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.225,
                    height: MediaQuery.of(context).size.width * 0.225,
                    child: Shimmer.fromColors(
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
        Text(categoryType),
      ]),
    );
  }
}
