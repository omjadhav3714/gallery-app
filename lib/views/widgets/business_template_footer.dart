// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<DocumentSnapshot>(
      stream: _userStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                  title: Text("${snapshot.data!['businessName']}"),
                  isThreeLine: true,
                  subtitle:  Text(
                    "${snapshot.data!['businessPhone']} ${snapshot.data!['businessEmail']} ${snapshot.data!['businessWebsite']}",
                    style: const TextStyle(fontSize: 12),
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
