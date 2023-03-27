import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class FavouriteSchedule extends StatefulWidget {
  const FavouriteSchedule({super.key});

  @override
  State<FavouriteSchedule> createState() => _MyFavouriteSchedule();
}

class _MyFavouriteSchedule extends State<FavouriteSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Favourite'),
        backgroundColor: Colors.orange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("FAVOURITE PAGE")
        ],
      ),
    );
  }
}
