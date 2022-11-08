import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/entities/ProfileImage.dart';
import 'package:greetings_app/utils/scafffold_message_handler.dart';
import 'package:greetings_app/views/auth_pages/user_profile_view.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../entities/User.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/input_with_icon.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key, required this.data}) : super(key: key);
  final DocumentSnapshot<Map?>? data;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  // Declaring Necessary Variables

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  double windowWidth = 0;
  double windowHeight = 0;

  var user = FirebaseAuthServiceModel().getUserDetails();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.data!.data()!.containsKey('name')
            ? widget.data!['name']
            : null);
    phoneController = TextEditingController(
        text: widget.data!.data()!.containsKey('phone')
            ? widget.data!['phone']
            : null);
  }

  void editProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      users.doc(user!.email).update({
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim()
      }).then((value) async {
        await Provider.of<FirebaseAuthServiceModel?>(context, listen: false)
            ?.updateUserData(name: nameController.text.trim());
        MessageHandler.showSnackBar(_scaffoldKey, "Profile Updated");
        setState((() {
          nameController.clear();
          phoneController.clear();
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? profileImage =
        Provider.of<ProfileImage?>(context)?.getProfileImage;

    // Size of the Screen
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/userProfile");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
          backgroundColor: white,
          elevation: 0,
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (profileImage != null)
                            ? AvatarImage(
                                image: profileImage,
                                isNetworkImage: true,
                              )
                            : AvatarImage(
                                image: user?.photoUrl ?? defaultProfileImageURL,
                                isNetworkImage:
                                    user?.photoUrl != null ? true : false,
                              ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: const Text(
                            editProfileText,
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthButtonWidget(
                      btnTxt: editProfileButtonText,
                      onPress: () {
                        editProfile();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
