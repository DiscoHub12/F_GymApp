import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import '../Models/account.dart';
// ignore: library_prefixes

class ProfileImagePage extends StatefulWidget {
  const ProfileImagePage({super.key, required this.booleanChoice});
  // ignore: prefer_typing_uninitialized_variables
  final booleanChoice;

  @override
  State<ProfileImagePage> createState() => _MyProfileImagePage();
}

class _MyProfileImagePage extends State<ProfileImagePage> {
  late Uint8List _pickedImage = Uint8List(1);
  late Account account =
      Account('', '', '', DateTime.now(), DateTime.now(), _pickedImage);

  final boxAccount = BoxesAccount.getAccount();

  void _pickImage() async {
    final pickedImage = await ProfileImagePicker.pickImage();
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage as Uint8List;
        account.profileImage = _pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Image'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          // ignore: unnecessary_null_comparison
          if (account.profileImage != null)
            Image.memory(boxAccount.getAt(0)!.profileImage)
          else
            const Placeholder(),
          widget.booleanChoice
              ? ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7))),
                  child: const Text('Choice Image'),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ProfileImagePicker {
  static Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return null;
    return File(pickedImage.path);
  }
}
