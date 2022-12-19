// ignore_for_file: file_names, invalid_return_type_for_catch_error

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../utils/utils.dart';
import '../views/edit_pages/edit_page_view.dart';
import '../views/widgets/default_button_view.dart';
import 'TextInfoModel.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class EditImageViewModel extends State<EditPageView> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  /// It takes a screenshot of the screen, saves it to the gallery, and then displays a snackbar to the
  /// user
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that calls the function.
  saveToGallery(BuildContext context) {
    // if (texts.isNotEmpty) {
    screenshotController.capture().then((Uint8List? image) {
      saveImage(image!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(savedGallery),
        ),
      );
    }).catchError((err) => debugPrint(err));
    // }
  }

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

  /// It takes a Uint8List of bytes, converts it to a PNG image, and saves it to the device's gallery
  ///
  /// Args:
  ///   bytes (Uint8List): The image data in bytes.
  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  /// The function takes in a context and an index, sets the currentIndex to the index, and then displays
  /// a snackbar
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that is calling the function.
  ///   index: The index of the selected item.
  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          selectStyling,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  /// It changes the color of the text.
  ///
  /// Args:
  ///   color (Color): The color to change the text to.
  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  /// It increases the font size of the text in the current index.
  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  /// It takes the current index of the text and decreases the font size by 2
  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  /// It sets the textAlign property of the current text to TextAlign.left
  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  /// It sets the textAlign property of the current text to center
  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  /// It sets the textAlign property of the current text to TextAlign.right
  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  /// If the current text is bold, make it normal. If it's normal, make it bold
  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  /// If the current text is italic, make it normal. If it's normal, make it italic
  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  /// If the text contains a new line character, replace it with a space. Otherwise, replace the spaces
  /// with new line characters
  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  /// The function removes the text at the current index of the list
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that is calling the function.
  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          removed,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  /// It adds a new TextInfo object to the texts list
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left,
        ),
      );
      Navigator.of(context).pop();
    });
  }

  /// This function is called when the user clicks on the add text button. It opens a dialog box with a
  /// text field and two buttons. The first button closes the dialog box and the second button calls the
  /// addNewText function
  ///
  /// Args:
  ///   context: The context of the widget that is calling the dialog.
  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(addTitle),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: FaIcon(FontAwesomeIcons.pencil),
            filled: true,
            hintText: enterText,
          ),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            color: white,
            textColor: black,
            child: const Text(back, style: TextStyle(color: black)),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            color: primaryColor,
            textColor: white,
            child: const Text(addText),
          ),
        ],
      ),
    );
  }
}
