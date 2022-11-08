import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/controllers/AuthRedirectController.dart';
import 'package:greetings_app/views/auth_pages/add_profile_image_view.dart';
import 'package:greetings_app/views/auth_pages/login_page_view.dart';
import 'package:greetings_app/views/auth_pages/forgot_password_page_view.dart';
import 'package:greetings_app/views/auth_pages/user_profile_view.dart';
import 'package:greetings_app/views/home_page/HomePageView.dart';
import 'package:provider/provider.dart';
import 'entities/User.dart';
import 'models/authentication/FirebaseAuthServiceModel.dart';
import 'views/all_category_pages/all_categories_view.dart';
import 'views/explore_pages/explore_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider for base class instance of [FirebaseAuthServiceModel]
        Provider<FirebaseAuthServiceModel>(
          create: (_) => FirebaseAuthServiceModel(),
        ),
        // Provider for instance of UserModel
        Provider<UserData?>(
          create: (_) => FirebaseAuthServiceModel().getUserDetails(),
        ),
      ],
      child: MaterialApp(
        title: 'Greetings App',
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryColor,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const AuthRedirectController(),
          "/login": (context) => const LoginPageView(),
          "/setProfileImage" : (context) => const AddProfileImageView(),
          "/forgotPassword":(context) =>  const ForgotPasswordView(),
          "/home": (context) => const HomePageView(),
          "/userProfile" : (context) => const UserProfileView(),
          "/allCategories" : (context) => const AllCategoriesGridView(),
          "/explore" : (context) => const ExplorePageView(),
        },
      ),
    );
  }
}
