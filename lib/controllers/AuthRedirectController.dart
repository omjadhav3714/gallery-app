import 'dart:ui';
import 'package:greetings_app/entities/User.dart';
import 'package:greetings_app/models/authentication/FirebaseAuthServiceModel.dart';
import 'package:greetings_app/views/auth_pages/login_page_view.dart';
import 'package:greetings_app/views/category_pages/subcategory_view.dart';
import 'package:greetings_app/views/home_page/HomePageView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRedirectController extends StatelessWidget {
  const AuthRedirectController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServiceProvider = Provider.of<FirebaseAuthServiceModel>(context);
    return StreamBuilder<UserData?>(
      stream: authServiceProvider.onAuthStateChanged(context),
      builder: (_, AsyncSnapshot<UserData?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        } else {
          final user = snapshot.data;
          debugPrint(
              "**************** YO2 ${user?.displayName} ******* ${user?.email}");
          if (user != null) {
            debugPrint("*************** HELLO HOMEPAGE *****************");
            // Go to HomePage
            return const HomePageView();
          }
          return const LoginPageView();
        }
      },
    );
  }
}
