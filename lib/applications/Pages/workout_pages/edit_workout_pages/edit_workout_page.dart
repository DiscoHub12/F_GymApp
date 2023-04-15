import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/exercise.dart';
import 'package:gymapp/applications/Pages/workout_pages/edit_workout_pages/edit_day_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/inside_workout_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/workout_page.dart';
import '../../../Models/day_schedule.dart';
import '../../../Models/workout.dart';
// ignore: library_prefixes

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({super.key, required this.workout});
  final Workout workout;

  @override
  State<EditWorkoutPage> createState() => _MyEditWorkoutPage();
}

class _MyEditWorkoutPage extends State<EditWorkoutPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  List<DaySchedule> _days = [];
  List<TextEditingController> _nameNewDays = [];

  @override
  void initState() {
    _nameController.text = widget.workout.nome;
    _daysController.text = widget.workout.giorni.toString();
    _days = widget.workout.listaGiorni;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workout Schedule '),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: _updateWorkout,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name Workout'),
            TextField(
              controller: _nameController,
            ),
            const SizedBox(height: 16.0),
            const Text('Number of days'),
            TextField(
              controller: _daysController,
            ),
            const SizedBox(height: 16.0),
            const Center(
              child: Text(
                'Press single day to edit',
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height - 380,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  DaySchedule day = _days[index];
                  return ListTile(
                      title: Text(day.muscoliAllenati),
                      subtitle: Text('${day.esercizi.length} esercizi'),
                      onTap: () async {
                        // Apriamo la pagina per modificare il singolo giorno
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditDayPage(day: day))));
                        setState(() {});
                      },
                      onLongPress: () => setState(() {
                            _dialogNumberExercise(context, index, day);
                          }));
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () => _addNewDay(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Add Day'),
            ))
          ],
        ),
      ),
    );
  }

  Widget _requestRemoving(BuildContext context, index, DaySchedule day) =>
      Container(
        padding: const EdgeInsets.all(8),
        height: 140,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                day.muscoliAllenati,
                style: const TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Are you sure you want to delete ? '),
              ElevatedButton(
                onPressed: () => setState(() {
                  widget.workout.removeGiorno(day);
                  Navigator.pop(context);
                }),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );

  void _dialogNumberExercise(
      BuildContext context, index, DaySchedule schedule) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestRemoving(context, index, schedule),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addNewDay(BuildContext context) {
    List<Exercise> newListDaySchedule = [];
    var newDaySchedule = DaySchedule("New Day", newListDaySchedule);
    setState(() {
      _days.add(newDaySchedule);
    });
  }

  void _updateWorkout() {
    // Aggiorniamo il workout con i dati inseriti dall'utente
    widget.workout.nome = _nameController.text;
    widget.workout.giorni = int.parse(_daysController.text);
    widget.workout.listaGiorni = _days;
    // Aggiorniamo l'oggetto Hive
    widget.workout.save();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const WorkoutPage()));
  }
}
