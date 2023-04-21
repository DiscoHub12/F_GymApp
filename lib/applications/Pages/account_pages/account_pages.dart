import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';

import '../../Utils/splash_screen.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;
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
              child: Column(
                children: [
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
                      child: SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                  boxAccount.getAt(0)!.profileImage)))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    boxAccount.getAt(0)!.nome,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
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
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          const ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4),
                                            leading: Icon(Icons.my_location),
                                            title: Text('Location'),
                                            subtitle: Text('Subtitle'),
                                          ),
                                          const ListTile(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.mode_edit),
      ),
    );
  }
}
