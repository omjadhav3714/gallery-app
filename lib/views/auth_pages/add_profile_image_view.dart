import 'package:flutter/material.dart';

class AddProfileImageView extends StatefulWidget {
  const AddProfileImageView({Key? key}) : super(key: key);

  @override
  State<AddProfileImageView> createState() => _AddProfileImageViewState();
}

class _AddProfileImageViewState extends State<AddProfileImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Expanded(
              child: TextButton(
                child: const Text("Choose a photo"),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
