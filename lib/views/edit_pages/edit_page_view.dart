// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:greetings_app/views/widgets/business_template_footer.dart';
import 'package:greetings_app/views/widgets/round_edge_filled_button.dart';
import 'package:screenshot/screenshot.dart';
import '../widgets/backbutton_widget_view.dart';
import '../widgets/template_footer_view.dart';
import './../../models/EditImageViewModel.dart';

class EditPageView extends StatefulWidget {
  final Uint8List editedImage;
  const EditPageView({Key? key, required this.editedImage}) : super(key: key);

  @override
  _EditPageViewState createState() => _EditPageViewState();
}

class _EditPageViewState extends EditImageViewModel {
  bool showProfile = true;
  bool showBusinessProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButtonWidget(iconColor: white),
        elevation: 0,
        title: const Text(
          edit,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Screenshot(
              controller: screenshotController,
              child: SafeArea(
                child: Column(
                  children: [
                    selectedImage,
                    showProfile ? const TemplateFooter(): const SizedBox(),
                    showBusinessProfile ? const BusinessTemplateFooter(): const SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundEdgeFilledButton(
                backgroundColor: primaryColor,
                buttonText: showProfile ? "Remove Profile" : "Add Profile",
                onPressed: () {
                  setState(() {
                    showProfile = !showProfile;
                  });
                },
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundEdgeFilledButton(
                backgroundColor: primaryColor,
                buttonText: showBusinessProfile ? "Remove Business Profile" : "Add Business Profile",
                onPressed: () {
                  setState(() {
                    showBusinessProfile = !showBusinessProfile;

                  });
                },
              ),
            ),
          ],
        ),
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
