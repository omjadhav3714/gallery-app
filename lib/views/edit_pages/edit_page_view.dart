// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/widgets/business_template_footer.dart';
import 'package:greetings_app/views/widgets/round_edge_filled_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import '../widgets/backbutton_widget_view.dart';
import '../widgets/template_footer_view.dart';

class EditPageView extends StatefulWidget {
  final Uint8List editedImage;
  const EditPageView({Key? key, required this.editedImage}) : super(key: key);

  @override
  _EditPageViewState createState() => _EditPageViewState();
}

class _EditPageViewState extends State<EditPageView> {
  bool showProfile = true;
  bool showBusinessProfile = false;
  ScreenshotController screenshotController = ScreenshotController();

  /// It takes a screenshot of the current screen, saves it to the device's local storage, and then
  /// shares it
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that is calling the shareImage function.
  shareImage(BuildContext context) async {
    screenshotController.capture().then((Uint8List? image) async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = image!.buffer.asUint8List();
      File imgFile = File('$directory/photo.png');
      await imgFile.writeAsBytes(pngBytes);
      Share.shareFiles([imgFile.path]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButtonWidget(iconColor: white),
        elevation: 0,
        title: const Text(
          shareImageText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: darkBackgroundColor,
        actions: [
          IconButton(
            icon: const FaIcon(
              Icons.share_outlined,
              size: 25,
            ),
            onPressed: () => shareImage(context),
            tooltip: 'Share Image',
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Column(
              children: [
                selectedImage,
                showProfile ? const TemplateFooter() : const SizedBox(),
                showBusinessProfile
                    ? const BusinessTemplateFooter()
                    : const SizedBox(),
              ],
            ),
          ),
          RoundEdgeFilledButton(
            backgroundColor: primaryColor,
            buttonText: showProfile ? "Remove Profile" : "Add Profile",
            onPressed: () {
              setState(() {
                showProfile = !showProfile;
                showBusinessProfile = false;
              });
            },
          ),
          RoundEdgeFilledButton(
            backgroundColor: primaryColor,
            buttonText: showBusinessProfile
                ? "Remove Business Profile"
                : "Add Business Profile",
            onPressed: () {
              setState(() {
                showBusinessProfile = !showBusinessProfile;
                showProfile = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget get selectedImage => Center(
        child: Image.memory(
          widget.editedImage,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );
}
