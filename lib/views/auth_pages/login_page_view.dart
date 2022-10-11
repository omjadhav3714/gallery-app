import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/forget_password_page_view.dart';
import 'package:greetings_app/views/utilities/show_error_view.dart';
import 'package:provider/provider.dart';
import '../../controllers/AuthController.dart';
import '../../entities/User.dart';
import '../widgets/authbutton_widget_view.dart';
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
            Transform.translate(
              offset: const Offset(0.0, 50.0),
              child: Image.asset(
                'assets/signin.png',
                height: 300,
              ),
            ),
            Expanded(
              child: Container(
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
                    ]),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          // color: Colors.red,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 22, bottom: 20),
                          child: const Text(
                            login,
                            style: TextStyle(
                              fontSize: 35,
                              color: black,
                              letterSpacing: 1,
                              fontFamily: "Lobster",
                            ),
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
                          height: 20,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthButtonWidget(
                          btnTxt: loginB,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              // Trigger Login functionality
                              await AuthController().loginWithEmailPassword(
                                  context,
                                  emailController.text,
                                  passwordController.text);
                              if (mounted) {
                                var user = Provider.of<UserData?>(context,
                                    listen: false);
                                showBottomNotificationMessage(
                                    context, user!.authStatusMessage!);
                              }
                            }
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: 70,
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
            )
          ],
        ),
      ),
    );
  }
}
