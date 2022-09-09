import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/forget_password_page_view.dart';
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
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: grey,
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(-40.0, 40.0),
              child: Image.asset(
                'assets/signin.png',
                height: 300,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
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
                            letterSpacing: 2,
                            fontFamily: "Lobster",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFieldView(
                        ctrl: emailCtrl,
                        labelTxt: email,
                        placholderTxt: emailP,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldView(
                        ctrl: passCtrl,
                        labelTxt: password,
                        placholderTxt: passwordP,
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
                      const AuthButtonWidget(
                        btnTxt: loginB,
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
                          orLog,
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
            )
          ],
        ),
      ),
    );
  }
}
