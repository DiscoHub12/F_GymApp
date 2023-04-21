import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import '../Models/account.dart';
// ignore: library_prefixes

class ProfileImagePage extends StatefulWidget {
  const ProfileImagePage({super.key});

  @override
  State<ProfileImagePage> createState() => _MyProfileImagePage();
}

class _MyProfileImagePage extends State<ProfileImagePage> {
  late File _pickedImage = File('');
  late Account account =
      Account('', '', '', DateTime.now(), DateTime.now(), _pickedImage);

  final boxAccount = BoxesAccount.getAccount();

  void _pickImage() async {
    final pickedImage = await ProfileImagePicker.pickImage();
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
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
          if (account.profileImage != null)
            Image.file(boxAccount.getAt(0)!.profileImage)
          else
            const Placeholder(),
          /**
           * ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            child: const Text('Choice Image'),
          ),@
           */
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
