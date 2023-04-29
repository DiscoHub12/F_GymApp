import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: library_prefixes
import '../Models/workout.dart';
import '../Utils/drawer.dart' as Drawer;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _MyCalendarPage();
}

class _MyCalendarPage extends State<CalendarPage> {
  DateTime today = DateTime.now();

  late Map<DateTime, List<Event>> selectedEvents;

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    List<DaySchedule> tmp = [];
    selectedEvents[DateTime(2023, 3, 29)]?.add(
        Event(date: DateTime(2023, 3, 29), workout: Workout('Prova1', 4, tmp)));
    selectedEvents[DateTime(2023, 4, 22)]?.add(
        Event(date: DateTime(2023, 4, 22), workout: Workout('Prova2', 4, tmp)));
    selectedEvents[DateTime(2023, 4, 23)]?.add(
        Event(date: DateTime(2023, 4, 23), workout: Workout('Prova3', 4, tmp)));
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer.NavigationDrawer(),
      body: Column(
        children: <Widget>[
          TableCalendar(
            focusedDay: today,
            firstDay: DateTime(2010, 10, 1),
            lastDay: DateTime(2030, 3, 14),
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
            eventLoader: _getEventsFromCalendar,
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  List<Event> _getEventsFromCalendar(DateTime date) {
    return selectedEvents[date] ?? [];
  }
}

class Event {
  final DateTime date;
  final Workout workout;

  Event({required this.date, required this.workout});
}
