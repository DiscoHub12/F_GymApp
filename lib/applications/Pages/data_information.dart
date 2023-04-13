import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class DataInfo extends StatefulWidget {
  const DataInfo({super.key});

  @override
  State<DataInfo> createState() => _MyDataInfo();
}

class _MyDataInfo extends State<DataInfo> {
  final String username = "Username";
  final int numSchede = 10;
  final String lastWorkout = "1";
  final String lastSchedule = "Schedule";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Workout Information'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              child: Text(
                username[0].toUpperCase(),
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Benvenuto, $username!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiche allenamenti",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Ultimo allenamento: $lastWorkout"),
                    Text("Ultima scheda utilizzata: $lastSchedule"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiche schede",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Numero di schede: $numSchede"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
