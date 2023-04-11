import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/exercise.dart';
import 'package:gymapp/applications/Models/favourite_list_workout.dart';
import 'package:gymapp/applications/Models/workout.dart';
// ignore: unnecessary_import
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
  Hive.registerAdapter(FavouriteWorkoutAdapter());
  //Open the Hive Box :
  await Hive.openBox<Account>('getAccount');
  await Hive.openBox<Exercise>('getExercise');
  await Hive.openBox<DaySchedule>('getDaySchedule');
  await Hive.openBox<Workout>('getWorkout');
  await Hive.openBox<FavouriteWorkout>('getFavouriteWorkout');
  runApp(const MaterialApp(home: App()));
}
