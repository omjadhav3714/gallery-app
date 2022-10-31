import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import '../../constants/strings.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/input_with_icon.dart';

class CompleteBusinessProfile extends StatefulWidget {
  const CompleteBusinessProfile({Key? key}) : super(key: key);

  @override
  State<CompleteBusinessProfile> createState() => _CompleteBusinessProfileState();
}

class _CompleteBusinessProfileState extends State<CompleteBusinessProfile> {
  // Declaring Necessary Variables

  final _formKey = GlobalKey<FormState>();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessPhoneController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();

  double windowWidth = 0;
  double windowHeight = 0;

  var user = FirebaseAuthServiceModel().getUserDetails();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    businessEmailController.dispose();
    businessNameController.dispose();
    businessPhoneController.dispose();
    super.dispose();
  }

  void completeBusinessProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      users.doc(user!.email).update({
        "businessEmail": businessEmailController.text,
        "businessName": businessNameController.text,
        "businessPhone": businessPhoneController.text,
        "businessWebsite": businessWebsiteController.text
      }).then((value) => {
            setState((() {
              businessNameController.clear();
              businessPhoneController.clear();
              businessEmailController.clear();
              businessWebsiteController.clear();
            }))
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size of the Screen
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, "/userProfile", (route) => false);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: black,
      ),
    ),
        backgroundColor: white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child:  const Text(
                      businessProfileButtonText,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InputWithIcon(
                obscure: false,
                btnIcon: Icons.account_circle_rounded,
                hintText: businessName,
                myController: businessNameController,
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
              const SizedBox(
                height: 20,
              ),
              InputWithIcon(
                btnIcon: Icons.phone,
                hintText: businessPhone,
                myController: businessPhoneController,
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
              const SizedBox(
                height: 20,
              ),
              InputWithIcon(
                btnIcon: Icons.email_outlined,
                hintText: businessEmail,
                myController: businessEmailController,
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
              const SizedBox(
                height: 20,
              ),
              InputWithIcon(
                btnIcon: Icons.email_outlined,
                hintText: businessWebsite,
                myController: businessWebsiteController,
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
                keyboardType: TextInputType.name,
                obscure: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthButtonWidget(
                btnTxt: businessProfileButtonText,
                onPress: () {
                  completeBusinessProfile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
