import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/models/authentication/FirebaseAuthServiceModel.dart';
import 'package:greetings_app/views/widgets/appbar_view.dart';
import '../../entities/User.dart';
import '../../fakes/fakeData.dart';
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

    var user = FirebaseAuthServiceModel().getUserDetails();
    debugPrint("################ ${user!.displayName} ################");
    Widget getAppBarTitleForHomePage() {
      return Row(
        children: [
          const Text("Welcome ", style: TextStyle(color: Colors.black)),
          Text(user.displayName ?? "to Gallery App!",
              style: const TextStyle(color: primaryColor)),
        ],
      );
    }

    // Provider.of<UserData?>(context, listen: false)?.updateUserUsingObject(user);

    return Scaffold(
        // endDrawer: const NavBarView(),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
        appBar:
            AppBarView().getCustomAppBar(title: getAppBarTitleForHomePage()),
        body: Column(
          children: [
            // Initial GridView for Featured Cards
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView(gridCardsList: gridCardList),
            ),
            const Text(
              "Categories",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: CategoriesGridView(),
            ),
          ],
        ));
  }
}
