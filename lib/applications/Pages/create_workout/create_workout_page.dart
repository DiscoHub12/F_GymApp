import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_workout.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/workout.dart';
import 'package:gymapp/applications/Pages/create_workout/compile_day_worrkout.dart';

import '../../Models/exercise.dart';
import '../../Utils/print_message.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class MyCreateSchedule extends StatefulWidget {
  const MyCreateSchedule({super.key});

  @override
  State<MyCreateSchedule> createState() => _MyTwoCreateSchedule();
}

class _MyTwoCreateSchedule extends State<MyCreateSchedule> {
  //Object type  PrintStatus:
  PrintStatus statusMessage = PrintStatus();

  final TextEditingController _nameWorkout = TextEditingController();
  final TextEditingController _numberDays = TextEditingController();

  int days = 0;
  int count = 0;

  bool showOk = false;

  late List<Exercise> _exerciseDay = [];
  final TextEditingController _numberExercise = TextEditingController();
  final TextEditingController _muscles = TextEditingController();
  // ignore: unused_field
  late List<DaySchedule> _daySchedule = [];
  // ignore: unused_field
  late final Workout _newWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        
        title: const Text('New Workout'),
        centerTitle: true,
        
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            _formWidgetString('Name Workout', 'Name',
                'Please enter a Workout name', _nameWorkout),
            const SizedBox(
              height: 10,
            ),
            _formWidgetNumber('Number of Days', 'Number',
                'Please enter a positive Number', _numberDays),
            !showOk
                ? ElevatedButton(
                    onPressed: () => _saveDays(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    child: const Text('OK'),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 480,
              width: 200,
              child: Expanded(
                child: ListView.builder(
                    itemCount: days,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text('Compile Day ${index + 1}'),
                        onPressed: () {
                          _dialogNumberExercise(context, index + 1);
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveAll(context);
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.save),
      ),
    );
  }

  /// For simplicity, without having
  /// to instantiate and create objects
  /// directly within the build method,
  /// they are created out separately for a simpler
  /// code structure and modular.
  Widget _formWidgetString(
          hintText, labelText, errorText, TextEditingController controller) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 59, 36, 36)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(
                  color: Colors.orange,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Colors.black, width: 1.0))),
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
      );

  Widget _formWidgetNumber(
          hintText, labelText, errorText, TextEditingController controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 59, 36, 36)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(
                  color: Colors.orange,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Colors.black, width: 1.0))),
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
      );

  Widget _requestNumberExercise(BuildContext context, index) => Container(
        padding: const EdgeInsets.all(8),
        height: 260,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                'Day $index',
                style: const TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 16,
              ),
              _formWidgetString(
                  'Muscle(s)?', 'Muscles', 'Enter a valid Muscles', _muscles),
              const SizedBox(height: 13),
              _formWidgetNumberExercise('Number of Exercise ? ', 'Number',
                  'Enter positive number', _numberExercise),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    int days = int.parse(_numberExercise.value.text);
                    Navigator.pop(context);
                    for (int i = 0; i <= days; i++) {
                      _showCompileForm(context);
                      count++;
                    }
                    _closeExerciseCompiling(context);
                    _muscles.clear();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Compile')),
            ],
          ),
        ),
      );

  Widget _formWidgetNumberExercise(
          hintText, labelText, errorText, TextEditingController controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 59, 36, 36)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(
                  color: Colors.orange,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Colors.black, width: 1.0))),
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
      );

  //---------------INTERNAL METHODS--------------
  void _saveDays() {
    days = (int.parse(_numberDays.text));
    showOk = true;
    _newWorkout = Workout(_nameWorkout.text, days, _daySchedule);
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print('WORKOUT : \n + ' +
        _nameWorkout.text +
        "Numer of Days : " +
        days.toString());
    setState(() {});
  }

  //METHOD FOR THIS CLASS:
  void _showCompileForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: CompileExercise(_addExercises),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _dialogNumberExercise(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestNumberExercise(context, index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addExercises(Exercise schedule) {
    _exerciseDay.add(schedule);
    _numberExercise.clear();
    setState(() {});
    // ignore: avoid_print
    print(
        'Aggiunto : \n${schedule.nomeEsercizio}\n${schedule.ripetizioni}\n${schedule.peso}');
  }

  void _closeExerciseCompiling(BuildContext context) {
    String muscles = _muscles.text;
    DaySchedule tmp = DaySchedule(muscles, _exerciseDay);
    if (_newWorkout.listaGiorni.isEmpty) {
      List<DaySchedule> tmpList = [];
      tmpList.add(tmp);
    } else {
      _newWorkout.addGiorno(tmp);
    }
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print('Aggiungo giorno : \n Numero Esercizi : ' +
        _numberExercise.text +
        "\nMuscolo allenato : " +
        _muscles.value.text +
        "\nEsercizi : " +
        _exerciseDay.toString());
    _exerciseDay = [];
    _numberExercise.clear();
    _muscles.clear();
    Navigator.pop(context);
  }

  void _saveAll(BuildContext context) {
    //Add into the Database :
    final box = BoxesWorkout.getWorkout();
    box.add(_newWorkout);
    statusMessage.printCorrect(context, 'Workout add successfully');
    _clearAll();
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  void _clearAll() {
    _nameWorkout.clear();
    _numberDays.clear();
    days = 0;
    count = 0;
    showOk = false;
    _exerciseDay = [];
    _numberExercise.clear();
    _muscles.clear();
    // ignore: unused_field
    _daySchedule = [];
  }
}
