import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Utils/print_message.dart';
// ignore: library_prefixes
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: library_prefixes
import '../../../app.dart';

class ModifyAccount extends StatefulWidget {
  const ModifyAccount({super.key});

  @override
  State<ModifyAccount> createState() => _MyModifyAccount();
}

class _MyModifyAccount extends State<ModifyAccount> {
  //TextEditingController for Input:
  final TextEditingController name = TextEditingController();
  final TextEditingController cognome = TextEditingController();
  final TextEditingController email = TextEditingController();

  //File for change Photo:
  late File image;

  //Variable for print message :
  final PrintStatus printMessage = PrintStatus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('Assets/imageProfile.png')),
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
                    const SizedBox(
                      height: 17,
                    ),
                    _buttonSave(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Widget for this Class :
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

  Widget _buttonSave() => ElevatedButton.icon(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
        ),
        onPressed: () {
          _saveUpdate();
        },
      );

  //Method for this Class :
  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
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

  void _saveUpdate() {
    //Todo implementare
    // ignore: prefer_interpolation_to_compose_strings, avoid_print
    print('Nome : ' +
        name.text +
        "Cognome : " +
        cognome.text +
        "Email : " +
        email.text);
    resetController();
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const App()));
    printMessage.printCorrect(context, 'Updated Data Correctly.');
  }

  void resetController() {
    name.clear();
    cognome.clear();
    email.clear();
  }
}
