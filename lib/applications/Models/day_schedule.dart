import 'package:gymapp/applications/Models/exercise.dart';
import 'package:hive/hive.dart';

part 'day_schedule.g.dart';

@HiveType(typeId: 1)
class DaySchedule extends HiveObject {
  @HiveField(0)
  String muscoliAllenati;

  @HiveField(1)
  List<Exercise> esercizi;

  @HiveField(2)
  DateTime? lastUsage;

  //Constructor Object:
  DaySchedule(this.muscoliAllenati, this.esercizi);

  //Get and Set Methods and Other :
  String getMuscoliAllenati() {
    return muscoliAllenati;
  }

  void setMuscoliAllenati(String muscoli) {
    muscoliAllenati = muscoli;
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
    return lastUsage!;
  }

  void setLastUsage(date) {
    lastUsage = date;
  }

  void removeLastUsage() {
    lastUsage == DateTime(0);
  }
}
