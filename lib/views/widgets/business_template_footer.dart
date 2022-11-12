// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../entities/User.dart';

class BusinessTemplateFooter extends StatefulWidget {
  const BusinessTemplateFooter({
    Key? key,
  }) : super(key: key);

  @override
  State<BusinessTemplateFooter> createState() => _BusinessTemplateFooterState();
}

class _BusinessTemplateFooterState extends State<BusinessTemplateFooter> {
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
                  title: Text("Name : " +
                      (snapshot.data!.data()!.containsKey('businessName')
                          ? snapshot.data!['businessName']
                          : '')),
                  isThreeLine: true,
                  subtitle: Text(
                    "Phone : " +
                        (snapshot.data!.data()!.containsKey('businessPhone')
                            ? snapshot.data!['businessPhone']
                            : '') +
                        "\n" +
                        "Website : " +
                        (snapshot.data!.data()!.containsKey('businessWebsite')
                            ? snapshot.data!['businessWebsite']
                            : '') +
                        "\n" +
                        "Email : " +
                        (snapshot.data!.data()!.containsKey('businessEmail')
                            ? snapshot.data!['businessEmail']
                            : ''),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              snapshot.data!.data()!.containsKey('businessLogo')
                  ? SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          snapshot.data!['businessLogo'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, exception, stackTrack) =>
                              SizedBox(
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
                    )
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
