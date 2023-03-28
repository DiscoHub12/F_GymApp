import 'package:flutter/material.dart';
// ignore: library_prefixes
import './applications/Utils/drawer.dart' as Drawer;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.orange,
      ),
      drawer: const Drawer.NavigationDrawer(),
      body: const Column(
        children: <Widget>[Text('HELLO')],
      ),
    );
  }
}