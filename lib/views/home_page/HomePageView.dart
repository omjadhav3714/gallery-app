import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/views/widgets/appbar_view.dart';
import 'package:provider/provider.dart';
import '../../entities/User.dart';
import '../utilities/bottom_navigation_bar.dart';
import '../widgets/categories_grid_view.dart';
import '../widgets/staggered_grid_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context)!;
    Widget getAppBarTitleForHomePage() {
      final Stream<DocumentSnapshot<Map>> _userStream = FirebaseFirestore
          .instance
          .collection('Users')
          .doc(user.email)
          .snapshots(includeMetadataChanges: true);
      return StreamBuilder<DocumentSnapshot<Map>>(
          stream: _userStream,
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
            return Row(
              children: [
                const Text(
                  "Welcome ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  snapshot.data!.data()!.containsKey('name')
                      ? snapshot.data!['name']
                      : "Gallery App!",
                  style: const TextStyle(
                    color: primaryColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      // endDrawer: const NavBarView(),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
      appBar: AppBarView().getCustomAppBar(title: getAppBarTitleForHomePage()),
      body: Column(
        children: const [
          // Initial GridView for Featured Cards
          Padding(
            padding: EdgeInsets.all(8.0),
            child: StaggeredGridView(),
          ),
          Text(
            "Categories",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: CategoriesGridView(),
          ),
        ],
      ),
    );
  }
}
