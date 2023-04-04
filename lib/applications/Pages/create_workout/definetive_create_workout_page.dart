import 'package:flutter/material.dart';
import 'package:gymapp/applications/Utils/print_message.dart';

import '../../../app.dart';
import '../../Data/boxes_workout.dart';
import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';
import '../../Models/workout.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class DefinitiveCreate extends StatefulWidget {
  const DefinitiveCreate({super.key});

  @override
  State<StatefulWidget> createState() => _MyDefinitiveCreate();
}

class _MyDefinitiveCreate extends State<DefinitiveCreate> {
  final PrintStatus statusMessage = PrintStatus();

  final List<DaySchedule> tmp = [];
  Workout? _workoutCreated;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameWorkout = TextEditingController();
  final TextEditingController _dayWorkout = TextEditingController();

  final Map<DaySchedule, _CompleteDay> _controllerMap = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('New Workout'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            onPressed: _salvaScheda,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameWorkout,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un nome valido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dayWorkout,
                decoration: const InputDecoration(
                  labelText: "Numero di giorni",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Inserisci il numero di giorni";
                  }
                  if (int.tryParse(value) == null) {
                    return "Inserisci un numero valido";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "Workout Day",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controllerMap.keys.length,
                  itemBuilder: (context, indexGiorno) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Giorno ${indexGiorno + 1}",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  _rimuoviGiorno(indexGiorno);
                                },
                              )
                            ],
                          ),
                          Container(
                            width: 300,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Muscles",
                              ),
                              initialValue: _controllerMap.entries
                                  .elementAt(indexGiorno)
                                  .value
                                  .muscles
                                  .text,
                              onChanged: (value) {
                                setState(() {
                                  _controllerMap.entries
                                      .elementAt(indexGiorno)
                                      .value
                                      .muscles
                                      .text = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _controllerMap.entries
                                  .elementAt(indexGiorno)
                                  .value
                                  .exercises
                                  .length,
                              itemBuilder: (context, indexEsercizio) {
                                return Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "Esercizio ${indexEsercizio + 1}",
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                _rimuoviEsercizio(indexGiorno,
                                                    indexEsercizio);
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: "Name Exercise",
                                              ),
                                              initialValue: _controllerMap
                                                  .entries
                                                  .elementAt(indexGiorno)
                                                  .value
                                                  .exercises
                                                  .elementAt(indexEsercizio)
                                                  .nomeEsercizio
                                                  .text,
                                              onChanged: (value) {
                                                setState(() {
                                                  _controllerMap.entries
                                                      .elementAt(indexGiorno)
                                                      .value
                                                      .exercises
                                                      .elementAt(indexEsercizio)
                                                      .nomeEsercizio
                                                      .text = value;
                                                });
                                              },
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  labelText: "Reps"),
                                              initialValue: _controllerMap
                                                  .entries
                                                  .elementAt(indexGiorno)
                                                  .value
                                                  .exercises
                                                  .elementAt(indexEsercizio)
                                                  .reps
                                                  .text,
                                              onChanged: (value) {
                                                setState(() {
                                                  _controllerMap.entries
                                                      .elementAt(indexGiorno)
                                                      .value
                                                      .exercises
                                                      .elementAt(indexEsercizio)
                                                      .reps
                                                      .text = value;
                                                });
                                              },
                                            ),
                                            TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: "Weight"),
                                                initialValue: _controllerMap
                                                    .entries
                                                    .elementAt(indexGiorno)
                                                    .value
                                                    .exercises
                                                    .elementAt(indexEsercizio)
                                                    .width
                                                    .text,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _controllerMap.entries
                                                        .elementAt(indexGiorno)
                                                        .value
                                                        .exercises
                                                        .elementAt(
                                                            indexEsercizio)
                                                        .width
                                                        .text = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _elevated(() {
                                _aggiungiEsercizio(indexGiorno);
                              }, 'Add Exercise'),
                              _elevated(() {
                                _salvaGiorno(indexGiorno);
                              }, 'Save day'),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 23.0,
              ),
              Center(
                child: _elevated(_aggiungiGiorno, 'Aggiungi Giorno'),
              )
            ],
          ),
        ),
      ),
    );
  }

  //WIDGET FOR THIS CLASS
  Widget _elevated(onPressed, String text) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Text(text),
      );

  /// Method for this Widget Component (Page):
  @override
  void dispose() {
    _nameWorkout.dispose();
    _dayWorkout.dispose();
    _controllerMap.clear();
    super.dispose();
  }

  void _aggiungiGiorno() {
    if (_workoutCreated == null || _workoutCreated!.listaGiorni.isEmpty) {
      List<DaySchedule> giorni = [];
      _workoutCreated =
          Workout(_nameWorkout.text, int.parse(_dayWorkout.value.text), giorni);
    }
    setState(() {
      List<Exercise> exerciseDay = [];
      _CompleteDay controllerDay = _CompleteDay();
      _controllerMap.putIfAbsent(
          DaySchedule("", exerciseDay), () => controllerDay);
      print('Ho aggiunto un giorno');
    });
  }

  void _rimuoviGiorno(int indexGiorno) {
    setState(() {
      DaySchedule daySchedule =
          _controllerMap.entries.elementAt(indexGiorno).key;
      _controllerMap.remove(daySchedule);
      print('Ho rimosso un giorno');
    });
  }

  void _aggiungiEsercizio(int indexGiorno) {
    setState(() {
      _CompleteExercise controllerExercises = _CompleteExercise();

      DaySchedule daySchedule =
          _controllerMap.entries.elementAt(indexGiorno).key;
      var controllerDay = _controllerMap.entries.elementAt(indexGiorno).value;
      controllerDay.addExercise(controllerExercises);
      _controllerMap.update(daySchedule, (value) => controllerDay);
      print('Ho aggiunto un Esercizio al giorno : ' + indexGiorno.toString());
    });
  }

  void _rimuoviEsercizio(int indexGiorno, int indexEsercizio) {
    setState(() {
      var controllerDay = _controllerMap.entries.elementAt(indexGiorno).value;
      controllerDay.exercises.removeAt(indexEsercizio);
      DaySchedule daySchedule =
          _controllerMap.entries.elementAt(indexGiorno).key;
      _controllerMap.update(daySchedule, (value) => controllerDay);
      print('Ho rimosso un Esercizio al giorno : ' + indexGiorno.toString());
    });
  }

  void _salvaGiorno(int indexGiorno) {
    String muscoliAllenati =
        _controllerMap.entries.elementAt(indexGiorno).value.muscles.text;
    List<Exercise> exerciseDay = [];
    for (int i = 0;
        i <
            _controllerMap.entries
                .elementAt(indexGiorno)
                .value
                .exercises
                .length;
        i++) {
      Exercise tmp = Exercise(
          _controllerMap.entries
              .elementAt(indexGiorno)
              .value
              .exercises
              .elementAt(i)
              .nomeEsercizio
              .text,
          _controllerMap.entries
              .elementAt(indexGiorno)
              .value
              .exercises
              .elementAt(i)
              .reps
              .text,
          double.parse(_controllerMap.entries
              .elementAt(indexGiorno)
              .value
              .exercises
              .elementAt(i)
              .width
              .text));
      exerciseDay.add(tmp);
    }
    DaySchedule newDaySchedule = DaySchedule(muscoliAllenati, exerciseDay);
    newDaySchedule.setLastUsage(null);
    if (_workoutCreated!.listaGiorni.isEmpty) {
      List<DaySchedule> daysSchedule = [];
      _workoutCreated!.setListaGiorni(daysSchedule);
      _workoutCreated!.addGiorno(newDaySchedule);
    } else {
      _workoutCreated!.addGiorno(newDaySchedule);
    }

    print("Giorno salvato");
  }

  Future<void> _salvaScheda() async {
    final box = BoxesWorkout.getWorkout();
    _workoutCreated = Workout(_nameWorkout.value.text,
        _controllerMap.entries.length, _controllerMap.keys.toList());
    await box.add(_workoutCreated!);
    print('WORKOUT CREATO.\n Nome Workout : ' +
        _workoutCreated!.nome +
        "\nNumero Giorni : " +
        _workoutCreated!.giorni.toString() +
        "\n");
    _stampaEsercizi(_workoutCreated!);
    // ignore: use_build_context_synchronously
    statusMessage.printCorrect(context, 'Workout Created.');
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const App()));
  }
}

void _stampaEsercizi(Workout workout) {
  for (int i = 0; i < workout.listaGiorni.length; i++) {
    print("ESERCIZIO NUMERO : " +
        i.toString() +
        "\n Muscoli allenati : " +
        workout.listaGiorni[i].muscoliAllenati);
    for (int j = 0; j < workout.listaGiorni[i].esercizi.length; j++) {
      print(
          "Esercizio numero $j : \n${workout.listaGiorni[i].esercizi[j].nomeEsercizio}\nRipetizioni : ${workout.listaGiorni[i].esercizi[j].ripetizioni}\n Peso : ${workout.listaGiorni[i].esercizi[j].peso}");
    }
  }
}

class _CompleteDay {
  TextEditingController muscles = TextEditingController();
  List<_CompleteExercise> exercises = [];

  TextEditingController getMuscleController() {
    return muscles;
  }

  void addExercise(_CompleteExercise exercise) {
    exercises.add(exercise);
  }

  void removeExercise(_CompleteExercise exercise) {
    exercises.remove(exercise);
  }

  List<_CompleteExercise> getListControllerExercise() {
    return exercises;
  }
}

class _CompleteExercise {
  TextEditingController nomeEsercizio = TextEditingController();
  TextEditingController reps = TextEditingController();
  TextEditingController width = TextEditingController();

  TextEditingController getNomeController() {
    return nomeEsercizio;
  }

  TextEditingController getRepsController() {
    return reps;
  }

  TextEditingController getWidthController() {
    return width;
  }
}
