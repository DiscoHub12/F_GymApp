import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:gymapp/applications/Pages/account_pages/account_pages.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/account.dart';

class ProfileImagePage extends StatefulWidget {
  const ProfileImagePage({super.key, required this.booleanChoice});
  // ignore: prefer_typing_uninitialized_variables
  final booleanChoice;

  @override
  State<ProfileImagePage> createState() => _MyProfileImagePage();
}

class _MyProfileImagePage extends State<ProfileImagePage> {
  final boxAccount = BoxesAccount.getAccount();
  bool isChoiced = false;
  late final File _newImages;

  void _pickImage() async {
    final pickedImage = await ProfileImagePicker.pickImage();
    if (pickedImage != null) {
      setState(() {
        _newImages = pickedImage;
        isChoiced = true;
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
          if (!isChoiced)
            Image.memory(boxAccount.getAt(0)!.profileImage)
          else if (isChoiced)
            Image.file(_newImages)
          // ignore: unnecessary_null_comparison
          else if (boxAccount.getAt(0)!.profileImage == null && !isChoiced)
            Image.asset('Assets/nullBackground.png')
          else
            const Placeholder(),
          const SizedBox(
            height: 20,
          ),
          widget.booleanChoice
              ? ElevatedButton(
                  onPressed: !isChoiced ? _pickImage : _saveImageProfile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7))),
                  child: isChoiced
                      ? const Text('Save')
                      : const Text('Choice Image'),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _saveImageProfile() async {
    var bytes = await _newImages.readAsBytes();
    Account account = boxAccount.getAt(0)!;
    account.setImageProfile(bytes);
    account.save();
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AccountPage()));
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
