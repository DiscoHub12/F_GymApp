import 'package:gymapp/applications/Models/workout.dart';
import 'package:hive/hive.dart';

class BoxesWorkout {
  static Box<Workout> getDataExpenses() => Hive.box<Workout>('getWorkout');
}
