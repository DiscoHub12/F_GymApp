import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:hive/hive.dart';

class BoxesDaySchedule {
  static Box<DaySchedule> getDataExpenses() =>
      Hive.box<DaySchedule>('getDaySchedule');
}
