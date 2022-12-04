import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/views/auth_pages/complete_business_profile_view.dart';
import 'package:greetings_app/views/auth_pages/edit_profile_view.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/profile_list_items.dart';
import '../../constants/strings.dart';
import '../../entities/User.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';

class ProfileListItems extends StatefulWidget {
  const ProfileListItems({Key? key}) : super(key: key);

  @override
  State<ProfileListItems> createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {
  @override
  Widget build(BuildContext context) {
        var user = Provider.of<UserData?>(context);

    final Stream<DocumentSnapshot<Map>> _userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<DocumentSnapshot<Map>>(
      stream: _userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
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

        return Expanded(
          child: ListView(
            children: <Widget>[
              ProfileListItem(
                icon: LineAwesomeIcons.user_shield,
                text: 'My Business Profile',
                onTapFunction: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CompleteBusinessProfile(data: snapshot.data)));
                },
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.edit_1,
                text: 'Edit Profile',
                onTapFunction: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditProfileView(data: snapshot.data)));
                },
              ),
               ProfileListItem(
                icon: LineAwesomeIcons.history,
                text: 'Forgot Password',
                onTapFunction: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
              ),
              // const ProfileListItem(
              //   icon: LineAwesomeIcons.cog,
              //   text: 'Settings',
              // ),
              // const ProfileListItem(
              //   icon: LineAwesomeIcons.user_plus,
              //   text: 'Invite a Friend',
              // ),
              ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'Logout',
                onTapFunction: () async {
                  await Provider.of<FirebaseAuthServiceModel>(context,
                          listen: false)
                      .signOutUser()
                      .then((value) => Navigator.pushNamedAndRemoveUntil(
                          context, "/", (route) => false));
                },
              ),
            ],
          ),
        );
      }
      
    );
  }
}