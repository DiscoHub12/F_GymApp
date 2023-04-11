import 'package:gymapp/applications/Models/workout.dart';
import 'package:hive/hive.dart';

part 'favourite_list_workout.g.dart';

@HiveType(typeId: 4)
class FavouriteWorkout extends HiveObject {
  @HiveField(0)
  List<Workout> workoutList;

  FavouriteWorkout(this.workoutList);

  void addWorkoutFavourite(Workout workout) {
    workoutList.add(workout);
  }

  void deleteWorkoutFavourite(Workout workout) {
    workoutList.remove(workout);
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }
}
