import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _MyChartPage();
}

class _MyChartPage extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Chart'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'SOON',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
