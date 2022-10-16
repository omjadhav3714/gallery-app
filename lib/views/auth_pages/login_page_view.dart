import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/forget_password_page_view.dart';
import 'package:greetings_app/views/utilities/show_error_view.dart';
import '../../controllers/AuthController.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/round_edge_filled_button.dart';
import '../widgets/socialbuttons_widget_view.dart';
import '../widgets/textfield_widget_view.dart';
import 'register_page_view.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: grey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Transform.translate(
                offset: const Offset(0.0, 50.0),
                child: Image.asset(
                  'assets/signin.png',
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.825,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 200, 200, 200),
                          blurRadius: 10.0,
                        ),
                      ],),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            login,
                            style: TextStyle(
                              fontSize: 25,
                              color: black,
                              letterSpacing: 1,
                              fontFamily: "Lobster",
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFieldView(
                            controller: emailController,
                            labelTxt: email,
                            placeholderTxt: emailP,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldView(
                            controller: passwordController,
                            labelTxt: password,
                            placeholderTxt: passwordP,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter password';
                              }
                              if (value.length < 6) {
                                return "Password length should be 6 characters";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPageView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  forgetP,
                                  style: TextStyle(color: greyDark),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RoundEdgeFilledButton(
                            buttonText: loginB,
                            onPressed: () async {
                              // Act only after the form fields are validated
                              if (_formKey.currentState!.validate()) {
                                // Trigger Login functionality
                                var userResult =
                                    await AuthController().loginWithEmailPassword(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                                // Show error messages if any
                                if (mounted) {
                                  debugPrint(userResult.toString());
                                  if (userResult!.authStatusMessage != null) {
                                    showBottomNotificationMessage(
                                      context,
                                      userResult.authStatusMessage!,
                                    );
                                  }
                                  Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                                }
                              }
                            },
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  doA,
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPageView(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    register,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              orLoginWith,
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SocialButtonWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
