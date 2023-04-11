import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';
import '../../Models/workout.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({super.key, required this.daySchedule});

  final DaySchedule daySchedule;

  @override
  State<StartWorkout> createState() => _MyStartWorkout();
}

class _MyStartWorkout extends State<StartWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.daySchedule.muscoliAllenati),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[],
      ),
      body: Container(),
    );
  }
}
