import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _MyAccount();
}

class _MyAccount extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("ACCOUNT PAGE")
        ],
      ),
    );
  }
}
