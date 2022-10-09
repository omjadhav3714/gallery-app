import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/auth_pages/login_page_view.dart';
import 'package:provider/provider.dart';
import '../../controllers/AuthController.dart';
import '../../entities/User.dart';
import '../utilities/show_error_view.dart';
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
  final _formKey = GlobalKey<FormState>();
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
                'assets/signup.png',
                height: 300,
                width: 600,
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
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 200, 200, 200),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
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
                            register,
                            style: TextStyle(
                              fontSize: 35,
                              color: black,
                              letterSpacing: 1,
                              fontFamily: "Lobster",
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: grey,
                          child: Icon(
                            Icons.camera_alt,
                            color: primaryColor,
                            size: 30.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldView(
                          controller: nameCtrl,
                          labelTxt: name,
                          placeholderTxt: nameP,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldView(
                          controller: emailCtrl,
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
                          controller: phoneCtrl,
                          labelTxt: contact,
                          placeholderTxt: contactP,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter phone no.';
                            } else if (value.length != 10) {
                              return 'Enter 10 digit phone no.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldView(
                          controller: passCtrl,
                          labelTxt: password,
                          placeholderTxt: passwordP,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 6) {
                              return "Password length should be 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthButtonWidget(
                          btnTxt: register,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              // debugPrint(emailCtrl.text +
                              //     passCtrl.text + nameCtrl.text + phoneCtrl.text);
                              // Trigger SignUp functionality
                              await AuthController().registerWithEmailPassword(
                                  context,
                                  emailCtrl.text,
                                  passCtrl.text,
                                  nameCtrl.text,
                                  phoneCtrl.text);
                              if (mounted) {
                                var user = Provider.of<UserData?>(context,
                                    listen: false);
                                if (user!.authStatusMessage != null) {
                                  showBottomNotificationMessage(
                                      context, user.authStatusMessage!);
                                }
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
                                      builder: (context) =>
                                          const LoginPageView(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
