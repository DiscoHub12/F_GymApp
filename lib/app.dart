import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
// ignore: library_prefixes
import './applications/Utils/drawer.dart' as Drawer;
import 'applications/Data/boxes_favourite.dart';
import 'applications/Data/boxes_workout.dart';
import 'applications/Models/workout.dart';
import 'applications/Pages/workout_pages/create_workout/create_workout_page.dart';
import 'applications/Pages/workout_pages/inside_workout_page.dart';
import 'applications/Utils/print_message.dart';
import 'applications/Utils/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MyApp();
}

class _MyApp extends State<App> {
  final boxAccount = BoxesAccount.getAccount();
  final boxWorkout = BoxesWorkout.getWorkout();
  final boxFavourite = BoxesFavourite.getWorkout();
  final _date = DateTime.now();
  final PrintStatus _printMessage = PrintStatus();

  bool isWorkoutEmpty = false;

  final TextEditingController searchWorkoutController =TextEditingController();

  bool isSearch = false;
  late Workout searched;

  @override
  void initState() {
    super.initState();
    if (boxWorkout.isEmpty) {
      isWorkoutEmpty = true;
    } else {
      isWorkoutEmpty = false;
    }
    // ignore: avoid_print
    print(isWorkoutEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        drawer: Drawer.NavigationDrawer(),
        body: SingleChildScrollView(
            child: Stack(children: [
          const SizedBox(
            height: 160,
            child: HeaderWidget(160, true),
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(boxAccount.getAt(0)!.nome,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: Text(
                  _date.day.toString(),
                  style: const TextStyle(
                    fontSize: 45,
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
              const SizedBox(
                height: 5,
              ),
              !isWorkoutEmpty
                  ? Stack(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: <Widget>[
                            Container(
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
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: searchWorkoutController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                255, 223, 223, 223),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: "eg: Schedule 1",
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            prefixIconColor: Colors.orange,
                                          ),
                                          onChanged: _searchWorkout(),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
                                            child: ListView.builder(
                                              itemCount: boxWorkout.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  elevation: 5,
                                                  child: ListTile(
                                                    title: Text(boxWorkout
                                                        .getAt(index)!
                                                        .nome),
                                                    subtitle: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Day : ${boxWorkout.getAt(index)!.listaGiorni.length}',
                                                        ),
                                                        const SizedBox(
                                                          width: 25.0,
                                                        ),
                                                        Text(
                                                          'Total Exercise : ${totalExercise(boxWorkout.getAt(index)!)}',
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Wrap(
                                                      spacing: 12,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: isFavourite(
                                                                  boxWorkout
                                                                      .getAt(
                                                                          index)!)
                                                              ? const Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Colors
                                                                      .yellow,
                                                                )
                                                              : const Icon(Icons
                                                                  .favorite_border),
                                                          onTap: () {
                                                            _addRemoveFavourite(
                                                              context,
                                                              boxWorkout.getAt(
                                                                  index)!,
                                                            );
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                          onTap: () {
                                                            _dialogNumberExercise(
                                                              context,
                                                              index,
                                                              boxWorkout
                                                                  .getAt(index)!
                                                                  .nome,
                                                            );
                                                            setState(() {});
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
                                                                    workout: boxWorkout
                                                                        .getAt(
                                                                            index)!,
                                                                  )));
                                                    },
                                                  ),
                                                );
                                              },
                                            )),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 70,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Center(
                              child: Text(
                                "You don't have any Workout",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Center(
                              child: Text(
                                "Create",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                      ],
                    ),
            ],
          ),
        ])));
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
                  boxWorkout.getAt(index)!.delete();
                  setState(() {});
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

  int totalExercise(Workout workout) {
    int totalExercise = 0;
    for (int i = 0; i < workout.listaGiorni.length; i++) {
      totalExercise += workout.listaGiorni.elementAt(i).esercizi.length;
    }
    return totalExercise;
  }

  DateTime? lastWorkoutDay() {
    var lastWorkoutDay =
        boxWorkout.getAt(0)!.listaGiorni.elementAt(0).lastUsage;
    for (var i = 0; i < boxWorkout.length; i++) {
      for (var j = 0; j < boxWorkout.getAt(i)!.listaGiorni.length; j++) {
        if (boxWorkout
                .getAt(i)!
                .listaGiorni
                .elementAt(j)
                .lastUsage!
                .millisecond >
            lastWorkoutDay!.millisecond) {
          lastWorkoutDay =
              boxWorkout.getAt(i)!.listaGiorni.elementAt(j).lastUsage;
        }
      }
    }
    return lastWorkoutDay;
  }

  void _addRemoveFavourite(BuildContext context, Workout workout) async {
    if (boxFavourite.getAt(0)!.workoutList.contains(workout)) {
      boxFavourite.getAt(0)!.deleteWorkoutFavourite(workout);
      _printMessage.printError(context, 'Workout remove to Favourite page.');
    } else {
      boxFavourite.getAt(0)!.addWorkoutFavourite(workout);
      _printMessage.printCorrect(context, 'Workout add to Favourite page.');
    }
    setState(() {});
  }

  bool isFavourite(Workout workout) {
    return boxFavourite.getAt(0)!.workoutList.contains(workout);
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

  _searchWorkout() {
    isSearch = true;
    final name = searchWorkoutController.value.text;
    for (int i = 0; i < boxWorkout.length; i++) {
      Workout tmp = boxWorkout.getAt(i)!;
      if (tmp.nome == name) {
        searched = tmp;
      }
    }
  }
}
