import 'package:gymapp/applications/Models/exercise.dart';

class DaySchedule {
  //Attributes class:
  String muscle;
  List<Exercise> esercizi;
  DateTime lastUsage;

  //Constructor Object:
  DaySchedule(this.muscle, this.esercizi, this.lastUsage);

  //Get and Set Methods and Other :
  String getMuscolo() {
    return muscle;
  }

  void setMuscolo(String muscolo) {
    muscle = muscolo;
  }

  List<Exercise> getEsercizi() {
    return esercizi;
  }

  void setEsercizi(List<Exercise> esercizi) {
    this.esercizi = esercizi;
  }

  void addExercise(Exercise exercise) {
    esercizi.add(exercise);
  }

  void removeExercise(Exercise exercise) {
    esercizi.remove(exercise);
  }

  DateTime getLastUsage() {
    return lastUsage;
  }

  void setLastUsage(DateTime date) {
    lastUsage = date;
  }

  void removeLastUsage() {
    lastUsage == DateTime(0);
  }
}
