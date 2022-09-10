import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/login_page_view.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/textfield_widget_view.dart';

class ForgetPageView extends StatefulWidget {
  const ForgetPageView({Key? key}) : super(key: key);

  @override
  State<ForgetPageView> createState() => _ForgetPageViewState();
}

class _ForgetPageViewState extends State<ForgetPageView> {
  TextEditingController emailCtrl = TextEditingController();
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
              offset: const Offset(0.0, 50.0),
              child: Image.asset(
                'assets/forget.png',
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
                          forgetP,
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
                        height: 40,
                      ),
                      const AuthButtonWidget(
                        btnTxt: submit,
                      ),
                      Container(
                        width: double.infinity,
                        height: 70,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPageView(),
                                  ),
                                );
                              },
                              child: const Text(
                                backto,
                                style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
