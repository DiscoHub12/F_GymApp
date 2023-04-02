import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/exercise.dart';
import 'package:gymapp/applications/Models/workout.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive Options:
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(DayScheduleAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  //Open the Hive Box :
  await Hive.openBox('getAccount');
  await Hive.openBox('getExercise');
  await Hive.openBox('getDaySchedule');
  await Hive.openBox('getWorkout');
  runApp(const MaterialApp(home: App()));
}
