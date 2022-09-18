// ignore_for_file: avoid_unnecessary_containers
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard(
      {Key? key, this.animationController, this.animation, this.data})
      : super(key: key);

  final QueryDocumentSnapshot? data;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: transparent,
              onTap: () {
                //
              },
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
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
                              imageUrl: data!["img"],
                              placeholder: (context, url) => SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.225,
                                height:
                                    MediaQuery.of(context).size.width * 0.225,
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.225,
                      child: OutlinedButton(
                        onPressed: () {},
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
    );
  }
}
