import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/forget_password_page_view.dart';
import 'package:greetings_app/views/auth_pages/login_page_view.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/textfield_widget_view.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
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
              offset: const Offset(-40.0, 13.0),
              child: Image.asset(
                'assets/signup.png',
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
                          register,
                          style: TextStyle(
                            fontSize: 35,
                            color: black,
                            letterSpacing: 2,
                            fontFamily: "Lobster",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: grey,
                            child: Icon(
                              Icons.camera_alt,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldView(
                        ctrl: nameCtrl,
                        labelTxt: name,
                        placholderTxt: nameP,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldView(
                        ctrl: emailCtrl,
                        labelTxt: email,
                        placholderTxt: emailP,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldView(
                        ctrl: phoneCtrl,
                        labelTxt: contact,
                        placholderTxt: contactP,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldView(
                        ctrl: passCtrl,
                        labelTxt: password,
                        placholderTxt: passwordP,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const AuthButtonWidget(
                        btnTxt: register,
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
                              already,
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
                                    builder: (context) => const LoginPageView(),
                                  ),
                                );
                              },
                              child: const Text(
                                loginB,
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
