import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _MySchedule();
}

class _MySchedule extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("SCHEDULE PAGE")
        ],
      ),
    );
  }
}
