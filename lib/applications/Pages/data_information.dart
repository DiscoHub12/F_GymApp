import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class DataInfo extends StatefulWidget {
  const DataInfo({super.key});

  @override
  State<DataInfo> createState() => _MyDataInfo();
}

class _MyDataInfo extends State<DataInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Workout Information'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Information Workout")],
      ),
    );
  }
}
