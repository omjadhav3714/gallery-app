// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../entities/User.dart';

class TemplateFooter extends StatefulWidget {
  const TemplateFooter({Key? key}) : super(key: key);

  @override
  State<TemplateFooter> createState() => _TemplateFooterState();
}

class _TemplateFooterState extends State<TemplateFooter> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context);
    final Stream<DocumentSnapshot<Map>> userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);

    return StreamBuilder<DocumentSnapshot<Map>>(
      stream: userStream,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
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

        return Material(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListTile(
                  title: Text(snapshot.data!['name'] ?? 'No name'),
                  isThreeLine: true,
                  subtitle: Text(
                    "${snapshot.data!['email']}" +
                        "\n" +
                        ((snapshot.data!.data()!.containsKey('phone')
                            ? (snapshot.data!['phone'] ?? '')
                            : '')),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    snapshot.data!['photoUrl'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, exception, stackTrack) => SizedBox(
                      height: 100,
                      width: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 45,
                              color: Theme.of(context).primaryColor,
                            ),
                            const Text(
                              "Not loaded!",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 150,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
