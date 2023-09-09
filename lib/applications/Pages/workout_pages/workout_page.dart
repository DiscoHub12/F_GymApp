import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_workout.dart';
import 'package:gymapp/applications/Data/boxes_favourite.dart';
import 'package:gymapp/applications/Models/favourite_list_workout.dart';
import 'package:gymapp/applications/Pages/workout_pages/create_workout/create_workout_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/inside_workout_page.dart';
import 'package:gymapp/applications/Utils/print_message.dart';
// ignore: library_prefixes
import '../../Models/workout.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _MyWoroutPage();
}

class _MyWoroutPage extends State<WorkoutPage> {
  bool isEmpty = false;

  final _boxWorkout = BoxesWorkout.getWorkout();
  // ignore: non_constant_identifier_names
  final _box_favourite = BoxesFavourite.getWorkout();
  final _date = DateTime.now();

  final PrintStatus _printMessage = PrintStatus();

  @override
  void initState() {
    super.initState();
    if (_boxWorkout.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
      print(_boxWorkout.length);
    }
    if (_box_favourite.isEmpty) {
      List<Workout> workoutFavourite = [];
      FavouriteWorkout favourite = FavouriteWorkout(workoutFavourite);
      _box_favourite.add(favourite);
      //print('Ho creato la lista di allenamenti preferiti.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Workout'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Container(
              width: size.width,
              height: size.height / 3,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 161, 20),
                    Color.fromARGB(255, 251, 199, 122),

                    /**
                     * Color(0xff8d70fe),
                    Color(0xff2da9ef),
                     */
                  ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTile(
                    leading: Text(
                      _date.day.toString(),
                      style: const TextStyle(
                        fontSize: 52,
                        color: Colors.black,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _getMonth(_date.month),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      _date.year.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Positioned(
                top: size.height / 4.5,
                left: 16,
                child: Container(
                  width: size.width - 32,
                  height: size.height / 1.4,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 244, 244),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: !isEmpty
                              ? ListView.builder(
                                  itemCount: _boxWorkout.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(
                                            _boxWorkout.getAt(index)!.nome),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                'Day : ${_boxWorkout.getAt(index)!.listaGiorni.length}'),
                                            const SizedBox(
                                              width: 25.0,
                                            ),
                                            Text(
                                                'Total Exercise : ${totalExercise(_boxWorkout.getAt(index)!)}')
                                          ],
                                        ),
                                        trailing: Wrap(
                                          spacing: 12,
                                          children: <Widget>[
                                            GestureDetector(
                                              child: isFavourite(
                                                      _boxWorkout.getAt(index)!)
                                                  ? const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.yellow,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite_border),
                                              onTap: () {
                                                _addRemoveFavourite(context,
                                                    _boxWorkout.getAt(index)!);
                                              },
                                            ),
                                            GestureDetector(
                                              child: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              onTap: () {
                                                _dialogNumberExercise(
                                                    context,
                                                    index,
                                                    _boxWorkout
                                                        .getAt(index)!
                                                        .nome);
                                              },
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InsideWorkoutPage(
                                                        workout: _boxWorkout
                                                            .getAt(index)!,
                                                      )));
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Center(
                                      child: Text(
                                        "You don't have any Workout",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Center(
                                      child: Text(
                                        "Create",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CreateWorkoutPage()));
                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7))),
                                        child: const Icon(Icons.create))
                                  ],
                                ),
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }

  Widget _requestRemoving(BuildContext context, index, name) => Container(
        padding: const EdgeInsets.all(8),
        height: 140,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Are you sure you want to delete ? '),
              ElevatedButton(
                onPressed: () => setState(() {
                  _boxWorkout.getAt(index)!.delete();
                  Navigator.pop(context);
                }),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );

  //METHOD FOR THIS WIDGET

  void _dialogNumberExercise(BuildContext context, index, name) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestRemoving(context, index, name),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addRemoveFavourite(BuildContext context, Workout workout) async {
    if (_box_favourite.getAt(0)!.workoutList.contains(workout)) {
      _box_favourite.getAt(0)!.deleteWorkoutFavourite(workout);
      _printMessage.printError(context, 'Workout remove to Favourite page.');
    } else {
      _box_favourite.getAt(0)!.addWorkoutFavourite(workout);
      _printMessage.printCorrect(context, 'Workout add to Favourite page.');
    }
    setState(() {});
  }

  bool isFavourite(Workout workout) {
    return _box_favourite.getAt(0)!.workoutList.contains(workout);
  }

  int totalExercise(Workout workout) {
    int totalExercise = 0;
    for (int i = 0; i < workout.listaGiorni.length; i++) {
      totalExercise += workout.listaGiorni.elementAt(i).esercizi.length;
    }
    return totalExercise;
  }

  DateTime? lastWorkoutDay() {
    var lastWorkoutDay =
        _boxWorkout.getAt(0)!.listaGiorni.elementAt(0).lastUsage;
    for (var i = 0; i < _boxWorkout.length; i++) {
      for (var j = 0; j < _boxWorkout.getAt(i)!.listaGiorni.length; j++) {
        if (_boxWorkout
                .getAt(i)!
                .listaGiorni
                .elementAt(j)
                .lastUsage!
                .millisecond >
            lastWorkoutDay!.millisecond) {
          lastWorkoutDay =
              _boxWorkout.getAt(i)!.listaGiorni.elementAt(j).lastUsage;
        }
      }
    }
    return lastWorkoutDay;
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String _getMonth(int number) {
    String month = months.elementAt(number - 1);
    return month;
  }
}
