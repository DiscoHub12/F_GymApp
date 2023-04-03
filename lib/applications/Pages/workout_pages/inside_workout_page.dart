import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Models/workout.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class InsideWorkout extends StatefulWidget {
  const InsideWorkout({super.key, required this.workout});

  final Workout workout;

  @override
  State<InsideWorkout> createState() => _MyInsideWorkout();
}

class _MyInsideWorkout extends State<InsideWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer.NavigationDrawer(),
        appBar: AppBar(
          title: Text(widget.workout.nome),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
              itemCount: widget.workout.giorni,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Day ${index + 1}',
                        style: const TextStyle(fontSize: 26,),
                      ),
                    
                      
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  //Qui ci dovrà andare una lista di tutte le schede segnate come favorite
  //Oppure giorni.,
}
