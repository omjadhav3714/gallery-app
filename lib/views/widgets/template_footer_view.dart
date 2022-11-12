// ignore_for_file: prefer_interpolation_to_compose_strings

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
    final Stream<DocumentSnapshot<Map>> _userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);

    return StreamBuilder<DocumentSnapshot<Map>>(
      stream: _userStream,
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
                  title: Text(user.displayName ?? 'No name'),
                  isThreeLine: true,
                  subtitle: Text(
                    "${snapshot.data!['email']}" + "\n" +
                        ((snapshot.data!.data()!.containsKey('phone')
                            ? (snapshot.data!['phone'] ?? '')
                            : '')),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                ),
                child: Image.network(
                  user.photoUrl ?? '',
                  fit: BoxFit.contain,
                  width: 80,
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
                            "Image cannot be loaded!",
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
                          width: 150,
                          height: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
