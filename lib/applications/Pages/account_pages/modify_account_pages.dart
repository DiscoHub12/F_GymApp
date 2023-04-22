import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:gymapp/applications/Pages/account_pages/account_pages.dart';
import 'package:gymapp/applications/Utils/print_message.dart';
// ignore: library_prefixes
// ignore: library_prefixes
import '../../Models/account.dart';
import '../../Utils/splash_screen.dart';
import '../change_image_page.dart';

class ModifyAccountPage extends StatefulWidget {
  const ModifyAccountPage({super.key});

  @override
  State<ModifyAccountPage> createState() => _MyModifyAccountPage();
}

class _MyModifyAccountPage extends State<ModifyAccountPage> {
  //TextEditingController for Input:
  final TextEditingController name = TextEditingController();
  final TextEditingController cognome = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController birthDay = TextEditingController();

  var dateTime = DateTime.now();

  //File for change Photo:
  late File image;

  //Variable for print message :
  final PrintStatus printMessage = PrintStatus();

  final boxAccount = BoxesAccount.getAccount();

  @override
  void initState() {
    super.initState();
    name.text = boxAccount.getAt(0)!.nome;
    cognome.text = boxAccount.getAt(0)!.cognome;
    email.text = boxAccount.getAt(0)!.email;
    dateTime = boxAccount.getAt(0)!.dataNascita;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Account'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.orange,
                Color.fromARGB(255, 255, 153, 0)
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, true),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 3, color: Colors.white),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(5, 5)),
                          ]),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(
                                    boxAccount.getAt(0)!.profileImage)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileImagePage(
                                          booleanChoice: true,
                                        )));
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
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Column(
                        children: <Widget>[
                          _textFormWidget(name, 'Enter name'),
                          _constSizedBox(),
                          _textFormWidget(cognome, 'Enter surname'),
                          _constSizedBox(),
                          _textFormWidget(email, 'Enter email'),
                          _constSizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateAccount();
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _textFormWidget(TextEditingController controller, String labelText) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black),
            labelText: labelText),
      );

  Widget _constSizedBox() => const SizedBox(
        height: 15,
      );

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: boxAccount.getAt(0)!.dataNascita,
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

  void _updateAccount() {
    Account account = boxAccount.getAt(0)!;
    account.setNome(name.text);
    account.setCognome(cognome.text);
    account.setEmail(email.text);
    account.save();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AccountPage()));
  }
}
