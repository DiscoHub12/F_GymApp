import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';
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
      appBar: AppBar(
        title: Text(widget.workout.nome),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4C4C4C), Color(0xFF2A2A2A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.workout.giorni,
          itemBuilder: (context, index) {
            DaySchedule day = widget.workout.listaGiorni[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Day ${index + 1}: ${day.muscoliAllenati}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const  ClampingScrollPhysics(),
                  itemCount: day.esercizi.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = day.esercizi[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise.nomeEsercizio,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Sets x Reps: ${exercise.ripetizioni}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Weight: ${exercise.peso}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                // Do something when the user presses the arrow button
                              },
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

  //Qui ci dovrà andare una lista di tutte le schede segnate come favorite
  //Oppure giorni.,

