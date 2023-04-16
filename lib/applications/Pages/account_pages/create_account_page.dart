import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app.dart';
import '../../Data/boxes_account.dart';
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

  bool choiceBirthDay = false;

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
                                        ? Image.asset(
                                            'Assets/nullBackground.png')
                                        : Image.file(file))),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  getGallery();
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
                        ),
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
                        ),
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
                      const Center(
                        child: Text(
                          'Year of birth',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final date = await pickDate();
                          if (date == null) return;
                          setState(() {
                            dateTime = date;
                            // ignore: avoid_print
                            print("Date : $dateTime");
                          });
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: Text(
                            '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
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

  void getGallery() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      choiceImage = true;
    });
  }

  void _submit() async {
    var finalFile;
    if (choiceImage) {
      finalFile = file;
    } else {
      finalFile = File('Assets/nullBackground.png');
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
        finalFile,
      );

      // aprire il box Hive e aggiungere l'oggetto Account
      var boxAccount = BoxesAccount.getAccount();
      await boxAccount.add(myAccount);

      print('Account inserito:\n'
          'Nome: ${myAccount.nome}\n'
          'Cognome: ${myAccount.cognome}\n'
          'Email: ${myAccount.email}\n'
          'File: ${finalFile.toString()}\n');

      runApp(const MaterialApp(home: App()));
    }
  }
}
