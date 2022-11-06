import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../controllers/AuthController.dart';
import '../utilities/show_error_view.dart';
import '../widgets/input_with_icon.dart';
import '../widgets/round_edge_filled_button.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: AnimatedContainer(
          padding: const EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(0, 0, 1),
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                forgotPasswordText,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                forgotPasswordDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
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
                obscure: false,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              RoundEdgeFilledButton(
                  buttonText: passwordResetSendEmailButtonText,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Trigger Google Sign in
                        await AuthController().forgotPassword(emailController.text.trim());

                        if (mounted) {
                          showBottomNotificationMessage(
                            context,
                            "Email sent successfully! Use the new password to login.",
                          );
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                        debugPrint('error sending email');
                        showBottomNotificationMessage(
                          context,
                          "Error resetting your password! Please try again.",
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
