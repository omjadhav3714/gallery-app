import 'package:flutter/material.dart';
import 'package:greetings_app/views/utilities/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../controllers/AuthController.dart';
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
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
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
                        style: const TextStyle(fontSize: 20.0),
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
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 90.0),
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<FirebaseAuthServiceModel>(context, listen: false).signOutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      elevation: 18,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "LogOut",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.8,
                  //   // ignore: deprecated_member_use
                  //   child: RaisedButton(
                  //     padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  //     child: const Text(
                  //       "Logout",
                  //       style: TextStyle(
                  //           fontSize: 20.0, fontWeight: FontWeight.bold),
                  //     ),
                  //     color: Theme.of(context).primaryColor,
                  //     textColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //     onPressed: () async {
                  //       await AuthController().logOutUser();
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Once you Logout, you won't be able to use any of the feature, You have to Login again to continue with the app.",
                      style: TextStyle(fontSize: 15),
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
