import 'package:hive/hive.dart';
part 'event.g.dart';

@HiveType(typeId: 6)
class Event extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime dateEvent;

  Event({required this.title, required this.dateEvent});

  String getTitle() {
    return title;
  }

  DateTime getDateEvent() {
    return dateEvent;
  }

  @override
  String toString() => title;
}
