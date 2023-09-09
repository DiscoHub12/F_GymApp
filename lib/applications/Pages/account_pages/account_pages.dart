import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:gymapp/applications/Pages/account_pages/modify_account_pages.dart';

import '../../Utils/splash_screen.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;
import '../change_image_page.dart';
// ignore: library_prefixes

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<AccountPage> {
  final boxAccount = BoxesAccount.getAccount();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
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
      drawer: Drawer.NavigationDrawer(),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProfileImagePage(
                                      booleanChoice: false,
                                    )));
                          },
                          child: SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                      boxAccount.getAt(0)!.profileImage))),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      boxAccount.getAt(0)!.nome,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'User Information',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 80,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    leading: const SizedBox(
                                      height: double.infinity,
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        color: Color.fromARGB(255, 22, 22, 22),
                                      ),
                                    ),
                                    title: Text(
                                        '${boxAccount.getAt(0)!.nome}  ${boxAccount.getAt(0)!.cognome}'),
                                    subtitle: const Text('Name - Surname'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    leading: const SizedBox(
                                      height: double.infinity,
                                      child: Icon(Icons.email,
                                          color:
                                              Color.fromARGB(255, 22, 22, 22)),
                                    ),
                                    title: Text(boxAccount.getAt(0)!.email),
                                    subtitle: const Text('Email'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    leading: const SizedBox(
                                      height: double.infinity,
                                      child: Icon(Icons.date_range,
                                          color:
                                              Color.fromARGB(255, 22, 22, 22)),
                                    ),
                                    title: Text(
                                        '${boxAccount.getAt(0)!.dataNascita.day}/${boxAccount.getAt(0)!.dataNascita.month}/${boxAccount.getAt(0)!.dataNascita.year}'),
                                    subtitle: const Text('Birthdate'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    leading: const SizedBox(
                                      height: double.infinity,
                                      child: Icon(Icons.date_range_outlined,
                                          color:
                                              Color.fromARGB(255, 22, 22, 22)),
                                    ),
                                    title: Text(
                                        '${boxAccount.getAt(0)!.dataIscrizione.day}/${boxAccount.getAt(0)!.dataIscrizione.month}/${boxAccount.getAt(0)!.dataIscrizione.year}'),
                                    subtitle: const Text('Registration date'),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ModifyAccountPage()));
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.manage_accounts),
      ),
    );
  }
}
