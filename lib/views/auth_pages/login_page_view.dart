import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import '../../controllers/AuthController.dart';
import '../utilities/show_error_view.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/input_with_icon.dart';
import '../widgets/outlined_button_with_image.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  // Declaring Necessary Variables
  int _pageState = 0;

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  Color _backgroundColor = white;
  Color _headingColor = primaryColor;
  Color _arrowColor = white;

  double _headingTop = 120;
  double _loginYOffset = 0;
  double _registerYOffset = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size of the Screen
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        _backgroundColor = white;
        _headingColor = primaryColor;
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _headingTop = 60;
        _arrowColor = white;
        break;
      case 1:
        _backgroundColor = primaryColor;
        _headingColor = white;
        _loginYOffset = 200;
        _registerYOffset = windowHeight;
        _headingTop = 30;
        _arrowColor = white;
        break;
      case 2:
        _backgroundColor = white;
        _headingColor = primaryColor;
        _loginYOffset = 200;
        _registerYOffset = 0;
        _headingTop = 30;
        _arrowColor = Colors.white;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 1000),
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: SafeArea(
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: _arrowColor,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (_pageState == 2) {
                            _pageState = 1;
                          } else {
                            _pageState = 0;
                          }
                        });
                      },
                    ),
                    AnimatedContainer(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 1000),
                      margin: EdgeInsets.only(top: _headingTop),
                      child: Text(
                        appName,
                        style: TextStyle(
                          color: _headingColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        introTagline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _headingColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Image.asset('assets/signup.png'),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 32),
                        child: AuthButtonWidget(
                          key: widget.key,
                          btnTxt: introNextButton,
                          backgroundColor: primaryColor,
                          onPress: () {
                            setState(() {
                              if (_pageState != 0) {
                                _pageState = 0;
                              } else {
                                _pageState = 1;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Login Section
          Form(
            key: loginFormKey,
            child: AnimatedContainer(
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _loginYOffset, 1),
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          loginPageHeading,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InputWithIcon(
                        btnIcon: Icons.email_outlined,
                        hintText: emailHintText,
                        myController: emailController,
                        validateFunc: (value) {
                          if (value!.isEmpty) {
                            return emailFieldEmpty;
                          } else if (!value.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                            return invalidEmailFormat;
                          }
                          return null;
                        },
                        obscure: false,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        btnIcon: Icons.vpn_key,
                        hintText: passwordHintText,
                        myController: passwordController,
                        obscure: true,
                        validateFunc: (value) {
                          if (value!.isEmpty) {
                            return passwordFieldEmpty;
                          } else if (value.length < 6) {
                            return passwordLengthWarning;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      TextButton(
                        onPressed: () async {
                          /*
                           final authServiceProvider =
                          Provider.of<AuthService>(context, listen: false);
                          try {
                            await authServiceProvider
                                .sendPasswordResetEmail(emailController.text);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Reset Password Email"),
                                  content: Text(
                                      "Reset password email has been sent to your email."),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: TextButton(
                                        child: Text("Got it"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            print(e);
                            print('error sending email');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Error sending reset email."),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: TextButton(
                                        child: Text("Try Again"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          */
                        },
                        child: Text(
                          forgotPasswordText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AuthButtonWidget(
                        btnTxt: loginButtonText,
                        onPress: () async {
                          // Act only after the form fields are validated
                          if (loginFormKey.currentState!.validate()) {
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
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomOutlineButton(
                        buttonText: googleLoginButtonText,
                        imageUrl: "assets/google_logo.png",
                        onPressed: () async {
                          // Trigger Google Sign in
                          await AuthController().loginWithGoogle();
                          if (mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomOutlineButton(
                        buttonText: signUpRedirectText,
                        onPressed: () {
                          setState(
                            () {
                              _pageState = 2;
                              emailController.clear();
                              passwordController.clear();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // SignUp Section
          Form(
            key: signUpFormKey,
            child: AnimatedContainer(
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _registerYOffset, 1),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: const Text(
                          signUpPageHeading,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  InputWithIcon(
                    obscure: false,
                    btnIcon: Icons.account_circle_rounded,
                    hintText: nameHintText,
                    myController: nameController,
                    keyboardType: TextInputType.name,
                    validateFunc: (val) {
                      String pattern = r'^[a-zA-Z]+[\s]+[a-zA-Z]+$';
                      RegExp regExp = RegExp(pattern);
                      if (val!.isEmpty) {
                        return nameEmptyWarning;
                      } else if (!regExp.hasMatch(val)) {
                        return invalidNameWarning;
                      }
                      return null;
                    },
                  ),
                  InputWithIcon(
                    btnIcon: Icons.phone,
                    hintText: phoneHintText,
                    myController: phoneController,
                    keyboardType: TextInputType.phone,
                    validateFunc: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value!.isEmpty) {
                        return phoneEmptyWarning;
                      } else if (!regExp.hasMatch(value)) {
                        return invalidPhoneWarning;
                      }
                      return null;
                    },
                    obscure: false,
                  ),
                  InputWithIcon(
                    btnIcon: Icons.email_outlined,
                    hintText: emailHintText,
                    myController: emailController,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return emailFieldEmpty;
                      } else if (!value.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                        return invalidEmailFormat;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    obscure: false,
                  ),
                  InputWithIcon(
                    btnIcon: Icons.vpn_key,
                    hintText: passwordHintText,
                    obscure: true,
                    myController: passwordController,
                    keyboardType: TextInputType.name,
                    validateFunc: (value) {
                      if (value!.isEmpty) {
                        return passwordFieldEmpty;
                      } else if (value.length < 6) {
                        return passwordLengthWarning;
                      }
                      return null;
                    },
                  ),
                  InputWithIcon(
                    btnIcon: Icons.vpn_key,
                    hintText: confirmPasswordHintText,
                    obscure: true,
                    myController: confirmPassController,
                    validateFunc: (val) {
                      if (val!.isEmpty) {
                        return confirmPasswordFieldEmpty;
                      }
                      if (val != passwordController.text) {
                        return confirmPasswordNotMatchingText;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButtonWidget(
                    btnTxt: signUpButtonText,
                    onPress: () async {
                      // Act only after the form fields are validated
                      if (signUpFormKey.currentState!.validate()) {
                        // Trigger SingUp functionality
                        var userResult = await AuthController()
                            .registerWithEmailPassword(
                                emailController.text.trim(),
                                confirmPassController.text.trim(),
                                nameController.text.trim(),
                                phoneController.text.trim());
                        // Show error messages if any
                        if (mounted) {
                          debugPrint(userResult.toString());
                          if (userResult?.authStatusMessage != null) {
                            showBottomNotificationMessage(
                              context,
                              userResult!.authStatusMessage!,
                            );
                          }
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/",
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                  CustomOutlineButton(
                    buttonText: loginRedirectText,
                    onPressed: () {
                      setState(
                        () {
                          _pageState = 1;
                          emailController.clear();
                          passwordController.clear();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
