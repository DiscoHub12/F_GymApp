import 'package:gymapp/applications/Models/favourite_list_workout.dart';
import 'package:hive/hive.dart';

class BoxesFavourite {
  static Box<FavouriteWorkout> getWorkout() =>
      Hive.box<FavouriteWorkout>('getFavouriteWorkout');
}
