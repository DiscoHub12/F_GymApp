import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _MyCreateSchedule();
}

class _MyCreateSchedule extends State<CreateSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Add Schedule'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("CREATE PAGE")
        ],
      ),
    );
  }
}
