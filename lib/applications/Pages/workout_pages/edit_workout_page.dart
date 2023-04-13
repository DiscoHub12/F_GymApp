import 'package:flutter/material.dart';

import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';
import '../../Models/workout.dart';
// ignore: library_prefixes

class EditWorkoutPage extends StatefulWidget {
  const EditWorkoutPage({super.key, required this.workout});
  final Workout workout;

  @override
  State<EditWorkoutPage> createState() => _MyEditWorkoutPage();
}

class _MyEditWorkoutPage extends State<EditWorkoutPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _daysController = TextEditingController();
  List<DaySchedule> _days = [];

  @override
  void initState() {
    _nameController.text = widget.workout.nome;
    _daysController.text = widget.workout.giorni.toString();
    _days = List.from(widget.workout.listaGiorni);
    super.initState();
  }

  void _updateWorkout() {
    // Aggiorniamo il workout con i dati inseriti dall'utente
    widget.workout.nome = _nameController.text;
    widget.workout.giorni = int.parse(_daysController.text);
    widget.workout.listaGiorni = _days;

    // Aggiorniamo l'oggetto Hive
    widget.workout.save();

    // Torniamo alla pagina precedente
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica scheda di allenamento'),
        actions: [
          IconButton(
            onPressed: _updateWorkout,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome della scheda di allenamento'),
            TextField(
              controller: _nameController,
            ),
            SizedBox(height: 16.0),
            Text('Numero di giorni'),
            TextField(
              controller: _daysController,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  DaySchedule day = _days[index];
                  return ListTile(
                    title: Text(day.muscoliAllenati),
                    subtitle:
                        Text(day.esercizi.length.toString() + ' esercizi'),
                    onTap: () async {
                      // Apriamo la pagina per modificare il singolo giorno
                      DaySchedule editedDay = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDayPage(
                            day: day,
                          ),
                        ),
                      );

                      // Se l'utente ha confermato le modifiche al giorno, aggiorniamo la lista di giorni
                      if (editedDay != null) {
                        setState(() {
                          _days[index] = editedDay;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditDayPage extends StatefulWidget {
  final DaySchedule day;

  EditDayPage({required this.day});

  @override
  _EditDayPageState createState() => _EditDayPageState();
}

class _EditDayPageState extends State<EditDayPage> {
  final _formKey = GlobalKey<FormState>();
  late String _muscoliAllenati;
  late List<Exercise> _esercizi;

  @override
  void initState() {
    super.initState();
    _muscoliAllenati = widget.day.muscoliAllenati;
    _esercizi = widget.day.esercizi;
  }

  void _addExercise() {
    setState(() {
      _esercizi.add(Exercise("", "", 0.0));
    });
  }

  void _removeExercise(int index) {
    setState(() {
      _esercizi.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modifica Scheda"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: _muscoliAllenati,
                        decoration: InputDecoration(
                          labelText: "Muscoli allenati",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Inserisci i muscoli allenati";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _muscoliAllenati = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Esercizi",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _esercizi.length,
                              itemBuilder: (context, index) {
                                return Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          _esercizi[index].nomeEsercizio,
                                      decoration: InputDecoration(
                                        labelText: "Nome Esercizio",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Inserisci il nome dell'esercizio";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _esercizi[index].nomeEsercizio = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          _esercizi[index].ripetizioni,
                                      decoration: InputDecoration(
                                        labelText: "Ripetizioni",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Inserisci le ripetizioni";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _esercizi[index].ripetizioni = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          _esercizi[index].peso.toString(),
                                      decoration: InputDecoration(
                                        labelText: "Peso",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Inserisci il peso";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _esercizi[index].peso =
                                            double.parse(value!);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ]);
                              }))
                    ]))));
  }
}
