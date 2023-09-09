import 'package:gymapp/applications/Models/day_schedule.dart';

class CalendarWorkout {
  DaySchedule daySchedule;
  DateTime timeWorkout;
  DateTime executionDate;

  CalendarWorkout(this.daySchedule, this.timeWorkout, this.executionDate);
}
