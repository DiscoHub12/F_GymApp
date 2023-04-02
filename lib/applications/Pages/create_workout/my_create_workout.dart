import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Models/schedule_total.dart';
import 'package:gymapp/applications/Pages/create_workout/compile_day_worrkout.dart';

import '../../Models/exercise.dart';

class MyCreateSchedule extends StatefulWidget {
  const MyCreateSchedule({super.key});

  @override
  State<MyCreateSchedule> createState() => _MyTwoCreateSchedule();
}

class _MyTwoCreateSchedule extends State<MyCreateSchedule> {
  final TextEditingController _nameWorkout = TextEditingController();
  final TextEditingController _numberDays = TextEditingController();

  int days = 0;

  bool showOk = false;

  final List<Exercise> _exerciseDay = [];
  final TextEditingController numberExercise = TextEditingController();
  // ignore: unused_field
  final List<DaySchedule> _daySchedule = [];
  // ignore: unused_field
  late final Workout _newWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: ListView.builder(
                  itemCount: days,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: Text('Compile Day ${index + 1}'),
                      onPressed: () {
                        _dialogNumberExercise(context);
                      },
                    );
                  }),
            )
          ],
        ),
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

  Widget _requestNumberExercise(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        height: 160,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              _formWidgetNumberExercise('Number of Exercise ? ', 'Number',
                  'Enter positive number', numberExercise),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  int days = int.parse(numberExercise.value.text);
                  Navigator.pop(context);
                  for (int i = 0; i < days; i++) {
                    _showCompileForm(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Icon(Icons.add),
              ),
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

  void _dialogNumberExercise(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestNumberExercise(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addExercises(Exercise schedule) {
    _exerciseDay.add(schedule);
    numberExercise.clear();
    setState(() {});
    // ignore: avoid_print
    print(
        'Aggiunto : \n${schedule.nomeEsercizio}\n${schedule.ripetizioni}\n${schedule.peso}');
  }
}
