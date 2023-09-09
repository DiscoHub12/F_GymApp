import 'package:flutter/material.dart';
import '../../../Models/day_schedule.dart';
import '../../../Models/exercise.dart';

class EditDayPage extends StatefulWidget {
  final DaySchedule day;

  const EditDayPage({super.key, required this.day});

  @override
  State<EditDayPage> createState() => _MyEditDayPage();
}

class _MyEditDayPage extends State<EditDayPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _muscoliController = TextEditingController();
  late List<Exercise> _esercizi;
  final List<_CompleteExercise> _controllerExercise = [];

  @override
  void initState() {
    super.initState();
    _muscoliController.text = widget.day.muscoliAllenati;
    _esercizi = widget.day.esercizi;
    for (int i = 0; i < _esercizi.length; i++) {
      var newControllerExercise = _CompleteExercise();
      newControllerExercise.nomeEsercizio.text =
          _esercizi.elementAt(i).nomeEsercizio;
      newControllerExercise.reps.text = _esercizi.elementAt(i).ripetizioni;
      newControllerExercise.width.text = _esercizi.elementAt(i).peso.toString();
      _controllerExercise.add(newControllerExercise);
      /**
     *   print("CONTROLLER $i : ");
      print("Nome : ${_controllerExercise.elem@entAt(i).nomeEsercizio.text}");
      print("Ripetizioni : ${_controllerExercise.elementAt(i).reps.text}");
      print("Peso : ${_controllerExercise.elementAt(i).width.text.toString()}");
     */
    }
    //print('Lunghezza controller : ${_controllerExercise.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit ${widget.day.muscoliAllenati}"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _muscoliController,
                        decoration: const InputDecoration(
                          labelText: "Muscles",
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        "Esercizi",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _esercizi.length,
                              itemBuilder: (context, index) {
                                return Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controllerExercise
                                          .elementAt(index)
                                          .nomeEsercizio,
                                      decoration: const InputDecoration(
                                        labelText: "Exercise name",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter exercise name";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controllerExercise
                                          .elementAt(index)
                                          .reps,
                                      decoration: const InputDecoration(
                                        labelText: "Reps",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter reps";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _controllerExercise
                                          .elementAt(index)
                                          .width,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Weight",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter weight";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  IconButton(
                                      onPressed: () => _removeExercise(index),
                                      icon: const Icon(Icons.delete))
                                ]);
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              _addExercise();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: const Text('Add Exercise'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _saveNewWeight(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: const Text('Save'),
                          )
                        ],
                      ),
                    ]))));
  }

  void _addExercise() {
    var completeExercise = _CompleteExercise();
    _controllerExercise.add(completeExercise);
    setState(() {
      _esercizi.add(Exercise("", "", 0.0));
    });
    //print("Indice esercizi : ${_esercizi.length}. \nIndice altro : ${_controllerExercise.length}");
  }

  void _removeExercise(int index) {
    setState(() {
      _esercizi.removeAt(index);
      _controllerExercise.removeAt(index);
    });
  }

  void _saveNewWeight(BuildContext context) {
    List<Exercise> updated = [];
    //print("Save Two methods : \nNumero Esercizi : ${_esercizi.length}.\nLunghezza Controller : ${_controllerExercise.length}");
    for (int i = 0; i < _controllerExercise.length; i++) {
      //print("ESERCIZIO FINALE $i");
      Exercise exerciseTmp = Exercise(
          _controllerExercise.elementAt(i).nomeEsercizio.value.text,
          _controllerExercise.elementAt(i).reps.value.text,
          double.parse(_controllerExercise.elementAt(i).width.value.text));
      //print("Nome : ${exerciseTmp.nomeEsercizio}");
      //print("Ripetizioni : ${exerciseTmp.ripetizioni}");
      //print("Peso : ${exerciseTmp.peso}");
      updated.add(exerciseTmp);
    }
    widget.day.esercizi = updated;
    widget.day.muscoliAllenati = _muscoliController.text;
    _controllerExercise.clear();
    _esercizi.clear();
    Navigator.pop(context);
    //print("Corretto.");
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
