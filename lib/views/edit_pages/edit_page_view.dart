// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greetings_app/constants/colors.dart';
import 'package:greetings_app/constants/strings.dart';
import 'package:screenshot/screenshot.dart';
import '../widgets/backbutton_widget_view.dart';
import '../widgets/image_text_view.dart';
import '../widgets/template_footer_view.dart';
import './../../models/EditImageViewModel.dart';

class EditPageView extends StatefulWidget {
  final String selectedImage;

  const EditPageView({Key? key, required this.selectedImage}) : super(key: key);

  @override
  _EditPageViewState createState() => _EditPageViewState();
}

class _EditPageViewState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButtonWidget(),
        elevation: 0,
        title: const Text(
          edit,
          style: TextStyle(
            color: primaryColor,
          ),
        ),
        backgroundColor: white,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.share,
              color: primaryColor,
              size: 25,
            ),
            onPressed: () => shareImage(context),
            tooltip: 'Share Image',
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Screenshot(
            controller: screenshotController,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        selectedImage,
                        for (int i = 0; i < texts.length; i++)
                          Positioned(
                            left: texts[i].left,
                            top: texts[i].top,
                            child: GestureDetector(
                              onLongPress: () {
                                currentIndex = i;
                                removeText(context);
                              },
                              onTap: () => setCurrentIndex(context, i),
                              child: Draggable(
                                feedback: ImageText(textInfo: texts[i]),
                                child: ImageText(textInfo: texts[i]),
                                onDragEnd: (drag) {
                                  final renderBox =
                                      context.findRenderObject() as RenderBox;
                                  Offset off =
                                      renderBox.globalToLocal(drag.offset);
                                  setState(() {
                                    texts[i].top = off.dy - 96;
                                    texts[i].left = off.dx;
                                  });
                                },
                              ),
                            ),
                          ),
                        creatorText.text.isNotEmpty
                            ? Positioned(
                                left: 0,
                                bottom: 0,
                                child: Text(
                                  creatorText.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: black.withOpacity(0.3),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const TemplateFooter(),
                ],
              ),
            ),
          ),
          Column(
            children: [
              editPart,
              getColorPart,
            ],
          )
        ],
      ),
      floatingActionButton: _addNewTextFab,
    );
  }

  Widget get selectedImage => Center(
        child: Image.network(
          widget.selectedImage,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addNewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: addTitle,
        child: const FaIcon(
          FontAwesomeIcons.pencil,
          color: primaryColor,
          size: 25,
        ),
      );

  Widget get editPart => Container(
        color: primaryColor.withOpacity(.5),
        child: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.solidFloppyDisk,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: () => saveToGallery(context),
                tooltip: 'Save Image',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: increaseFontSize,
                tooltip: 'Increase font size',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.minus,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: decreaseFontSize,
                tooltip: 'Decrease font size',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.alignLeft,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: alignLeft,
                tooltip: 'Align left',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.alignCenter,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: alignCenter,
                tooltip: 'Align Center',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.alignRight,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: alignRight,
                tooltip: 'Align Right',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bold,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: boldText,
                tooltip: 'Bold',
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.italic,
                  color: primaryColor,
                  size: 25,
                ),
                onPressed: italicText,
                tooltip: 'Italic',
              ),
              IconButton(
                icon: const Icon(
                  Icons.space_bar,
                  color: primaryColor,
                  size: 32,
                ),
                onPressed: addLinesToText,
                tooltip: 'Add New Line',
              ),
            ],
          ),
        ),
      );

  Widget get getColorPart => Container(
        color: primaryColor.withOpacity(.5),
        child: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.red),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.white),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.black),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.blue),
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.yellow),
                    child: const CircleAvatar(
                      backgroundColor: Colors.yellow,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.green),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Orange',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.orange),
                    child: const CircleAvatar(
                      backgroundColor: Colors.orange,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Pink',
                child: GestureDetector(
                    onTap: () => changeTextColor(Colors.pink),
                    child: const CircleAvatar(
                      backgroundColor: Colors.pink,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
}
