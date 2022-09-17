import 'package:flutter/material.dart';
import 'package:greetings_app/controllers/AuthController.dart';
import '../../controllers/UserController.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  @override
  Widget build(BuildContext context) {
    final user = UserController().getUserData(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName!),
            accountEmail: Text(user.email!),
            currentAccountPicture: user.photoUrl != null
                ? ClipOval(
                    child: Material(
                      elevation: 2.0,
                      shadowColor: Colors.black,
                      color: Colors.grey.shade600,
                      child: Image.network(
                        user.photoUrl!,
                        width: 60.0,
                        fit: BoxFit.fitHeight,
                      ),
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
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(user.displayName!),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          SizedBox(
            height: 1.0,
            child: Container(
              color: Colors.black38,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
              leading: const Icon(Icons.featured_play_list_outlined),
              title: const Text("All courses"),
              onTap: () {
                Navigator.pushNamed(context, '/allCourses');
              }),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text("About Us"),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              await AuthController().logOutUser();
            },
          )
        ],
      ),
    );
  }
}
