import 'package:flutter/material.dart';
import 'package:gymapp/applications/Pages/account_pages/modify_account_pages.dart';

import '../../Utils/splash_screen.dart';
// ignore: library_prefixes

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.orange, Colors.orange])),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: 100,
                child: HeaderWidget(100, false, Icons.account_box_rounded),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 5, color: Colors.white),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: const Offset(5, 5)),
                          ]),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nome',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'User Information',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                          color: Colors.grey,
                                          tiles: [
                                            ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              leading: Icon(Icons.my_location),
                                              title: Text('Location'),
                                              subtitle: Text('Subtitle'),
                                            ),
                                            ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              leading: Icon(Icons.my_location),
                                              title: Text('Location'),
                                              subtitle: Text('Subtitle'),
                                            ),
                                          ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
        /**
       *  SingleChildScrollView(
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
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              _containerInformation('Name', 'Il Mio nomme', Icons.person),
              const SizedBox(
                height: 15,
              ),
              _containerInformation('Surname', 'Il Mio Cognome', Icons.person),
              const SizedBox(
                height: 15,
              ),
              _containerInformation('Email', 'La mia email', Icons.email),
              const SizedBox(
                height: 15,
              ),
              _containerInformation('Age', 'La mia Eta', Icons.date_range),
              const SizedBox(
                height: 15,
              ),
              _buttonModify(),
            ],
          ),
        ),
      ),
       */
        );
  }

  //Widget for this clas:
  Widget _containerInformation(String nomeInfo, String nome, icon) => Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(icon),
            ),
            Text(nomeInfo,
                style: const TextStyle(
                  fontSize: 19,
                ),
                textAlign: TextAlign.center),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(nome,
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      );

  Widget _buttonModify() => ElevatedButton.icon(
        label: const Text('Modify'),
        icon: const Icon(Icons.update),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ModifyAccountPage()));
        },
      );
}
