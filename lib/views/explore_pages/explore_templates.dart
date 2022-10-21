// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../widgets/template_card_view.dart';

class ExploreTemplateView extends StatefulWidget {
  const ExploreTemplateView({Key? key})
      : super(key: key);

  @override
  _ExploreTemplateViewState createState() => _ExploreTemplateViewState();
}

class _ExploreTemplateViewState extends State<ExploreTemplateView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _templateStream = FirebaseFirestore.instance
        .collection('templates')
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _templateStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if (snapshot.hasError) {
          return const Text(wentWrong, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500),);
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
            child: Text(noData, style:  TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500),),
          );
        }

        return GridView(
          padding: const EdgeInsets.all(8),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.8,
          ),
          children: List<Widget>.generate(
            snapshot.data!.docs.length,
            (int index) {
              final int count = snapshot.data!.docs.length;
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController!,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              animationController?.forward();
              return TemplateCard(
                animation: animation,
                animationController: animationController,
                data: snapshot.data!.docs[index],
              );
            },
          ),
        );
      },
    );
  }
}
