// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_list_workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteWorkoutAdapter extends TypeAdapter<FavouriteWorkout> {
  @override
  final int typeId = 4;

  @override
  FavouriteWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteWorkout(
      (fields[0] as List).cast<Workout>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteWorkout obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.workoutList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
