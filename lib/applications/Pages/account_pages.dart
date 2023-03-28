import 'dart:io';

import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Other/image_string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../Utils/drawer.dart' as Drawer;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _MyAccount();
}

class _MyAccount extends State<AccountPage> {
  //TextEditingController for Input:
  final TextEditingController name = TextEditingController();
  final TextEditingController cognome = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController eta = TextEditingController();

  //File for change Photo:
  late File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Account'),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage(tProfileImage),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await getImage();
                          await saveImage();
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.orange,
                            ),
                            child: const Icon(
                              Icons.create_outlined,
                              size: 20.0,
                              color: Colors.black,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      _formField('Nome', name, Icons.person),
                      const SizedBox(
                        height: 10,
                      ),
                      _formField('Cognome', cognome, Icons.person),
                      const SizedBox(
                        height: 10,
                      ),
                      _formField('Email', email, Icons.email),
                      const SizedBox(
                        height: 10,
                      ),
                      _formField('Eta', email, Icons.date_range),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            final appDocumentsDirectory =
                await getApplicationDocumentsDirectory();
            final newFilePath = '${appDocumentsDirectory.path}/image.jpg';

            final newFile = await pickedFile.path == newFilePath;
          }
        }));
  }

  Widget _formField(String text, TextEditingController controller, icons) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          label: Text(text),
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(
            icons,
            color: Colors.black,
          ),
        ),
      );

  //Method for this Class :
  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/profile.png');
  }

  Future<void> saveImage() async {
    final file = await _localFile;
    await file.writeAsBytes(image.readAsBytesSync());
  }
}
