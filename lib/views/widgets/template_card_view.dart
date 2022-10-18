import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greetings_app/models/EditImageViewModel.dart';
import 'package:greetings_app/views/edit_pages/edit_page_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../image_plus/image_editor_plus.dart';

class TemplateCard extends StatefulWidget {
  const TemplateCard(
      {Key? key, this.animationController, this.animation, this.data})
      : super(key: key);

  final QueryDocumentSnapshot? data;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<TemplateCard> {
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
    return Stack(
      children: [
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 50 * (1.0 - widget.animation!.value), 0.0),
                child: InkWell(
                  splashColor: transparent,
                  onTap: () {
                    //
                  },
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: notWhite,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                              aspectRatio: 1.28,
                              child: CachedNetworkImage(
                                imageUrl: widget.data!["img"],
                                placeholder: (context, url) => SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.225,
                                  height:
                                      MediaQuery.of(context).size.width * 0.225,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[200]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.225,
                          child: OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var imageData =
                                  await getImageData(widget.data!["img"]);
                              if (mounted) {
                                // Getting the edited image and passing it to the next screen for adding business profile
                                var editedImage =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImageEditor(image: imageData),
                                  ),
                                );

                                if (editedImage != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           EditPageView(editedImage: editedImage),
                                    ),
                                  );
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: const Text(edit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        isLoading
            ? Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5)),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
