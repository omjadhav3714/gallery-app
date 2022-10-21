import 'package:flutter/material.dart';
import 'package:greetings_app/views/utilities/bottom_navigation_bar.dart';
import 'package:greetings_app/views/widgets/round_edge_filled_button.dart';
import 'package:provider/provider.dart';
import '../../entities/User.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context)!;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: GetClipper(),
            child: Container(color: Theme.of(context).primaryColor),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
              child: Column(
                children: [
                  user.photoUrl != null
                      ? ClipOval(
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                image: user.photoUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(user.photoUrl!),
                                        fit: BoxFit.cover)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 20.0, color: Colors.white)
                                ]),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            // color: CustomColors.firebaseGrey.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, color: Colors.black54),
                      Text(
                        " ${user.displayName!}",
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                    child: SizedBox(
                      height: 1.0,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, color: Colors.black54),
                      Text(
                        user.email!,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  RoundEdgeFilledButton(
                    buttonText: "Business Profile",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 40),
                  RoundEdgeFilledButton(
                    buttonText: "Edit Profile",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 40),
                  RoundEdgeFilledButton(
                    buttonText: "LogOut",
                    onPressed: () async {
                      await Provider.of<FirebaseAuthServiceModel>(context,
                              listen: false)
                          .signOutUser();
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Once you Logout, you won't be able to use any of the feature, You have to Login again to continue with the app.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width + 200, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
