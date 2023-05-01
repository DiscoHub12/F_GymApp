import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_workout.dart';
import 'package:gymapp/applications/Models/workout.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _MyCalendarPage();
}

class _MyCalendarPage extends State<CalendarPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _eventController = TextEditingController();

  final boxWorkout = BoxesWorkout.getWorkout();

  DateTime lastsWorkout = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    List<Event> tmpEvents = [];
    tmpEvents.add(Event(title: 'Titolo1'));
    selectedEvents[DateTime(2023, 4, 29)] = [Event(title: 'Titolo1')];
    selectedEvents[DateTime(2023, 4, 29)]!.add(Event(title: 'Titolo2'));
    selectedEvents.putIfAbsent(DateTime(2023, 4, 27), () => tmpEvents);
    if (lastWorkout() != DateTime.now()) {
      lastsWorkout = lastWorkout()!;
    }

    // ignore: avoid_print
    print(selectedEvents.toString());
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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
                        lastsWorkout.millisecond != DateTime.now().millisecond
                            ? '${lastsWorkout.day}/${lastsWorkout.month}/${lastsWorkout.year}'
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
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
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

  DateTime? lastWorkout() {
    DateTime? lastWorkout;
    for (int i = 0; i < boxWorkout.length; i++) {
      if (boxWorkout.getAt(i) != null) {
        Workout? tmp = boxWorkout.getAt(i);
        for (int j = 0; j < tmp!.listaGiorni.length; j++) {
          DateTime? last = tmp.listaGiorni.elementAt(i).lastUsage;
          if (lastWorkout!.isBefore(last!)) {
            lastWorkout = last;
          }
        }
      }
    }
    return lastWorkout;
  }
}

class Event {
  final String title;
  Event({required this.title});

  @override
  String toString() => title;
}
