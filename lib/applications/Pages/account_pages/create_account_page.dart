import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app.dart';
import '../../Data/boxes_account.dart';
import '../change_image_page.dart';
// ignore: library_prefixes

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _MyCreateAccount();
}

class _MyCreateAccount extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();
  late final DateTime birthDate;

  late File file;
  ImagePicker image = ImagePicker();
  bool choiceImage = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool choiceBirthDay = false;
  late File _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: Stack(
                          children: [
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: !choiceImage
                                        ? Image.asset('Assets/profile.png')
                                        : Image.file(_pickedImage))),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage();
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
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: "Name",
                            icon: Icon(Icons.person_2_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name required";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                            labelText: "Surname",
                            icon: Icon(Icons.person_2_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Surname required";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: 'BirthDay'),
                        onTap: () async {
                          final date = await pickDate();
                          if (date == null) return;
                          setState(() {
                            dateTime = date;
                            _dateController.text =
                                '${date.day}/${date.month}/${date.year}';
                            // ignore: avoid_print
                            print("Date : $dateTime");
                          });
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Colors.orange),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
              )),
          child: child!,
        );
      });

  void _pickImage() async {
    final pickedImage = await ProfileImagePicker.pickImage();
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
        choiceImage = true;
      });
    }
  }

  void _submit() async {
    // ignore: prefer_typing_uninitialized_variables
    var finalFile;
    var bytes;
    if (choiceImage) {
      finalFile = _pickedImage;
      bytes = await finalFile.readAsBytes();
    } else {
      finalFile = File('Assets/profile.png');
      bytes = await rootBundle.load('Assets/profile.png');
      bytes = bytes.buffer.asUint8List();
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // creare un oggetto Account con un campo File
      var myAccount = Account(
        _nameController.text,
        _surnameController.text,
        _emailController.text,
        DateTime.now(),
        dateTime,
        bytes,
      );

      // aprire il box Hive e aggiungere l'oggetto Account
      var boxAccount = BoxesAccount.getAccount();
      await boxAccount.add(myAccount);

      // ignore: avoid_print
      print('Account inserito:\n'
          'Nome: ${myAccount.nome}\n'
          'Cognome: ${myAccount.cognome}\n'
          'Email: ${myAccount.email}\n'
          'File: ${finalFile.toString()}\n');

      runApp(const MaterialApp(home: App()));
    }
  }
}
