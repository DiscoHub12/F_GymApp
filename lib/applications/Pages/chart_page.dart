import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class ChartSchedule extends StatefulWidget {
  const ChartSchedule({super.key});

  @override
  State<ChartSchedule> createState() => _MyChartSchedule();
}

class _MyChartSchedule extends State<ChartSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Chart'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("CHART PAGE")
        ],
      ),
    );
  }
}
