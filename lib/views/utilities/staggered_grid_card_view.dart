// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../../image_plus/image_editor_plus.dart';
import '../edit_pages/edit_page_view.dart';

class StaggeredGridCardView extends StatefulWidget {
  const StaggeredGridCardView({Key? key, required this.data}) : super(key: key);
  final QueryDocumentSnapshot? data;

  @override
  State<StaggeredGridCardView> createState() => _StaggeredGridCardViewState();
}

class _StaggeredGridCardViewState extends State<StaggeredGridCardView> {
  bool isLoading = false;

  /// Converts the network image to Uint8List format for image_editor_plus processing
  Future<Uint8List> getImageData(String url) async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          var imageData = await getImageData(widget.data!["img"]);
          if (mounted) {
            // Getting the edited image and passing it to the next screen for adding business profile
            var editedImage = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageEditor(image: imageData),
              ),
            );
            if (editedImage != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditPageView(editedImage: editedImage),
                ),
              );
            }
          }
          setState(() {
            isLoading = false;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: widget.data!['img'],
            placeholder: (context, url) => Shimmer.fromColors(
              period: const Duration(milliseconds: 500),
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
