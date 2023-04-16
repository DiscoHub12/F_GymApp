import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Models/FileAdapter/file_adapter.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/exercise.dart';
import 'package:gymapp/applications/Models/favourite_list_workout.dart';
import 'package:gymapp/applications/Models/workout.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'applications/Data/boxes_account.dart';
import 'applications/Pages/account_pages/create_account_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive Options:
  await Hive.initFlutter();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(DayScheduleAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(FavouriteWorkoutAdapter());
  Hive.registerAdapter(FileAdapter());
  //Open the Hive Box :
  await Hive.openBox<Account>('getAccount', path: appDocumentDirectory.path);
  await Hive.openBox<Exercise>('getExercise');
  await Hive.openBox<DaySchedule>('getDaySchedule');
  await Hive.openBox<Workout>('getWorkout');
  await Hive.openBox<FavouriteWorkout>('getFavouriteWorkout');

  var boxAccount = BoxesAccount.getAccount();
  if (boxAccount.isNotEmpty) {
    runApp(const MaterialApp(home: App()));
    print(
        'Account loggato : \nNome : ${boxAccount.getAt(0)!.nome}.\nCognome : ${boxAccount.getAt(0)!.cognome}.\nEmail : ${boxAccount.getAt(0)!.email}.\nData nascita: ${boxAccount.getAt(0)!.dataNascita}.\nFoto : ${boxAccount.getAt(0)!.profileImage}');
  } else {
    runApp(const MaterialApp(home: CreateAccount()));
  }
}
