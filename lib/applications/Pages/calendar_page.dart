import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_event.dart';
import 'package:gymapp/applications/Data/boxes_workout.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/workout.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Models/event.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _MyCalendarPage();
}

class _MyCalendarPage extends State<CalendarPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<Event>> selectedEvents = {};
  Map<DateTime, List<Event>> trailingDay = {};

  final TextEditingController _eventController = TextEditingController();

  final boxWorkout = BoxesWorkout.getWorkout();
  final boxEvent = BoxesEvent.getEvent();

  bool haveLast = false;
  DateTime lastDay = DateTime.now();

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    trailingDay = {};
    for (int i = 0; i < boxEvent.length; i++) {
      DateTime tmp = boxEvent.getAt(i)!.dateEvent;
      List<Event> tmpList = [];
      tmpList.add(boxEvent.getAt(i)!);
      selectedEvents.putIfAbsent(tmp, () => tmpList);
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print('Ecco gli Eventi : \nNome Evento $i' +
          boxEvent.getAt(i)!.title +
          "\nData Evento : " +
          boxEvent.getAt(i)!.dateEvent.toString());
    }

    for (int i = 0; i < boxWorkout.length; i++) {
      Workout tmp = boxWorkout.getAt(i)!;
      for (int j = 0; j < tmp.listaGiorni.length; j++) {
        DaySchedule tmpDay = tmp.listaGiorni.elementAt(i);
        if (tmpDay.lastUsage != null) {
          DateTime tmpDate = tmpDay.lastUsage!;
          List<Event> tmpEventWorkout = [];
          Event newEvent = Event(
              title: tmpDay.muscoliAllenati, dateEvent: tmpDay.lastUsage!);
          tmpEventWorkout.add(newEvent);
          trailingDay.putIfAbsent(tmpDate, () => tmpEventWorkout);
        }
      }
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer.NavigationDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Positioned(
                    right: -getSmallDiameter(context) / 3.3,
                    top: -getSmallDiameter(context) / 3.1,
                    child: Container(
                        width: getSmallDiameter(context),
                        height: getSmallDiameter(context),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 168, 37),
                                  Color.fromARGB(255, 253, 192, 101),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)))),
                Positioned(
                  left: -getBigDiameter(context) / 3,
                  top: -getBigDiameter(context) / 2.7,
                  child: Container(
                    width: getBigDiameter(context),
                    height: getBigDiameter(context),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              Color.fromARGB(255, 255, 181, 70),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Last Workout ',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        haveLast
                            ? '${lastDay.day}/${lastDay.month}/${lastDay.year}'
                            : 'Last Workout date not valid.',
                        //${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime(1990),
                        lastDay: DateTime(2050),
                        calendarFormat: format,
                        onFormatChanged: (CalendarFormat newFormat) {
                          setState(() {
                            format = newFormat;
                          });
                        },
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        daysOfWeekVisible: true,

                        //Day Changed
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                          });
                          // ignore: avoid_print
                          print(focusedDay);
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },

                        eventLoader: _getEventsfromDay,

                        //To style the Calendar
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 123, 0),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          selectedTextStyle:
                              const TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: const Color.fromARGB(255, 251, 207, 64),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 123, 0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ..._getEventsfromDay(selectedDay).map(
                        (Event event) => ListTile(
                          onLongPress: () {},
                          title: Text(
                            event.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  _saveEvent();
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  DateTime lastWorkout() {
    DateTime lastWorkout = DateTime.now();
    for (int i = 0; i < boxWorkout.length; i++) {
      if (boxWorkout.getAt(i) != null) {
        Workout? tmp = boxWorkout.getAt(i);
        for (int j = 0; j < tmp!.listaGiorni.length; j++) {
          DateTime? last = tmp.listaGiorni.elementAt(i).lastUsage;
          if (lastWorkout.isBefore(last!)) {
            lastWorkout = last;
          }
        }
      }
    }
    return lastWorkout;
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  Map<DateTime, List> _groupEventsByDate(List<DateTime> events) {
    Map<DateTime, List> data = {};
    for (DateTime event in events) {
      DateTime date = DateTime(event.year, event.month, event.day);
      data[date] = data[date] ?? [];
      data[date]!.add(event);
    }
    return data;
  }

  _saveEvent() {
    if (_eventController.text.isEmpty) {
    } else {
      if (selectedEvents[selectedDay] != null) {
        Event newTmp =
            Event(title: _eventController.text, dateEvent: selectedDay);
        selectedEvents[selectedDay]!.add(newTmp);
        boxEvent.add(newTmp);
        print(boxEvent);
      } else {
        Event newTmp =
            Event(title: _eventController.text, dateEvent: selectedDay);
        selectedEvents[selectedDay] = [newTmp];
        boxEvent.add(newTmp);
        print(boxEvent);
      }
    }
  }
}
