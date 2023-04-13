import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:intl/intl.dart';
// ignore: library_prefixes

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _MyCreateAccount();
}

class _MyCreateAccount extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _surname;
  late String _email;
  late TextEditingController dateController = TextEditingController();

  final _boxAccount = BoxesAccount.getAccount();

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
            padding: const EdgeInsets.all(16.0),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Crea il tuo account",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Nome",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Il nome è richiesto";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Cognome",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Il cognome è richiesto";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _surname = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "L'email è richiesta";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      _showCalendar(context),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text("Registrati"),
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

  Widget _showCalendar(BuildContext context) => TextField(
        controller: dateController,
        decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Enter Date",
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2023),
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat("yyyy-mm-dd").format(pickedDate);
            setState(() {
              dateController.text = formattedDate.toString();
            });
          }
        },
      );

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var file;
      Account account =
          // ignore: cast_from_nullable_always_fails
          Account(_name, _surname, _email, DateTime.now(), dateController.text,
              file as File);
      _boxAccount.add(account);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const App()));
      //TODO: eseguire l'azione di registrazione con i dati inseriti
    }
  }
}
