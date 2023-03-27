import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _MySettings();
}

class _MySettings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("SETTINGS PAGE")
        ],
      ),
    );
  }
}
