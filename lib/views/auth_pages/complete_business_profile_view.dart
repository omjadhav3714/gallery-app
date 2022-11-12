import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/strings.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';
import '../../utils/scafffold_message_handler.dart';
import '../widgets/authbutton_widget_view.dart';
import '../widgets/custom_image_picker_widget_view.dart';
import '../widgets/input_with_icon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CompleteBusinessProfile extends StatefulWidget {
  const CompleteBusinessProfile({Key? key, required this.data})
      : super(key: key);
  final DocumentSnapshot<Map?>? data;

  @override
  State<CompleteBusinessProfile> createState() =>
      _CompleteBusinessProfileState();
}

class _CompleteBusinessProfileState extends State<CompleteBusinessProfile> {
  // Declaring Necessary Variables

  final _formKey = GlobalKey<FormState>();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessPhoneController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  double windowWidth = 0;
  double windowHeight = 0;
  XFile? _imageFile;
  String? profileImg;
  late String _id;

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
      _id = FirebaseAuth.instance.currentUser!.uid;
      if (_imageFile != null) {
        // upload profile pic to firebase storage
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('users/$_id.jpg');
        await ref.putFile(File(_imageFile!.path));
        profileImg = await ref.getDownloadURL();
      }
      users.doc(user!.email).update({
        "businessEmail": businessEmailController.text,
        "businessName": businessNameController.text,
        "businessPhone": businessPhoneController.text,
        "businessWebsite": businessWebsiteController.text,
        "businessLogo": profileImg ??
            (widget.data!.data()!.containsKey('businessLogo')
                ? widget.data!['businessLogo']
                : ""),
      }).then((value) => {
            MessageHandler.showSnackBar(
                _scaffoldKey, "Business Profile Updated"),
            setState((() {
              businessNameController.clear();
              businessPhoneController.clear();
              businessEmailController.clear();
              businessWebsiteController.clear();
              _imageFile = null;
            }))
          });
    }
  }

  void _pickImageFromCamera() async {
    try {
      final pickImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickImage;
      });
    } catch (e) {
      setState(() {});
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickImage;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    businessEmailController = TextEditingController(
        text: widget.data!.data()!.containsKey('businessEmail')
            ? widget.data!['businessEmail']
            : null);
    businessNameController = TextEditingController(
        text: widget.data!.data()!.containsKey('businessName')
            ? widget.data!['businessName']
            : null);
    businessPhoneController = TextEditingController(
        text: widget.data!.data()!.containsKey('businessPhone')
            ? widget.data!['businessPhone']
            : null);
    businessWebsiteController = TextEditingController(
        text: widget.data!.data()!.containsKey('businessWebsite')
            ? widget.data!['businessWebsite']
            : null);
  }

  @override
  Widget build(BuildContext context) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _imageFile == null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundColor: primaryColor,
                                    backgroundImage: widget.data!
                                            .data()!
                                            .containsKey('businessLogo')
                                        ? NetworkImage(
                                            widget.data!['businessLogo'])
                                        : null,
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundColor: primaryColor,
                                    backgroundImage: FileImage(
                                      File(_imageFile!.path),
                                    ),
                                  ),
                            const SizedBox(
                              width: 30,
                            ),
                            CustomImagePickerWidget(
                              pickCamera: _pickImageFromCamera,
                              pickGallery: _pickImageFromGallery,
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: const Text(
                            businessProfileButtonText,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
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
                        if (val!.isEmpty) {
                          return nameEmptyWarning;
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
                      btnIcon: Icons.web,
                      hintText: businessWebsite,
                      myController: businessWebsiteController,
                      validateFunc: (val) {
                        if (val!.isEmpty) {
                          return nameEmptyWarning;
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
          ),
        ),
      ),
    );
  }
}
