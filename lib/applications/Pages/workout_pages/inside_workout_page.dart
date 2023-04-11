import 'package:flutter/material.dart';
import 'package:gymapp/applications/Pages/workout_pages/start_workout.dart';
// ignore: library_prefixes
import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';
import '../../Models/workout.dart';

class InsideWorkoutPage extends StatefulWidget {
  const InsideWorkoutPage({super.key, required this.workout});

  final Workout workout;

  @override
  State<InsideWorkoutPage> createState() => _MyInsideWorkoutPage();
}

class _MyInsideWorkoutPage extends State<InsideWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.nome),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 186, 83),
              Color.fromARGB(255, 199, 119, 0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.workout.giorni,
          itemBuilder: (context, index) {
            DaySchedule day = widget.workout.listaGiorni[index];
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Day ${index + 1}: ${day.muscoliAllenati}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartWorkout(
                                        daySchedule: day,
                                      )));
                        },
                        child: const Text(
                          'Start Workout',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: day.esercizi.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = day.esercizi[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 5),
                      child: Container(
                        padding: const EdgeInsets.all(10),
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

