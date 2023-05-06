import 'package:hive/hive.dart';

import '../Models/event.dart';

class BoxesEvent {
  static Box<Event> getEvent() =>
      Hive.box<Event>('getEvent');
}
