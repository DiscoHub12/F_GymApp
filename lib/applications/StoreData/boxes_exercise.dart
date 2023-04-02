import 'package:gymapp/applications/Models/exercise.dart';
import 'package:hive/hive.dart';

class BoxesExercise {
  static Box<Exercise> getDataExpenses() => Hive.box<Exercise>('getExercise');
}
