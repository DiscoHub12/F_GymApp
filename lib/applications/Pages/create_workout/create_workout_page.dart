import 'package:flutter/material.dart';
import '../../Models/schedule_total.dart';

class CreateSchedule extends StatefulWidget {
  final Workout? workout;

  const CreateSchedule({Key? key, this.workout}) : super(key: key);

  @override
  State<CreateSchedule> createState() => _MyCreateSchedule();
}

class _MyCreateSchedule extends State<CreateSchedule> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _daysController = TextEditingController();
  final List<List<TextEditingController>> _exerciseControllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      _nameController.text = widget.workout!.nome;
      _daysController.text = widget.workout!.giorni.toString();
      for (int i = 0; i < widget.workout!.giorni; i++) {
        _exerciseControllers.add([]);
        /**
         * 
for (int j = 0; j < widget.workout!.listaGiorni[i].length; j++) {
          _exerciseControllers[i].add(
              TextEditingController(text: widget.workout!.exercises[i][j]));
        }
         */
      }
    } else {
      _exerciseControllers.add([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout == null ? 'New Workout' : 'Edit Workout'),
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Workout Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a workout name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _daysController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of Days'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of days';
                  }
                  int days = int.tryParse(value) ?? 0;
                  if (days <= 0) {
                    return 'Please enter a positive number';
                  }
                  return null;
                },
                onChanged: (value) {
                  int days = int.tryParse(value) ?? 0;
                  while (_exerciseControllers.length < days) {
                    _exerciseControllers.add([]);
                  }
                  while (_exerciseControllers.length > days &&
                      _exerciseControllers.length > 1) {
                    _exerciseControllers.removeLast();
                  }
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _exerciseControllers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Day ${index + 1}'),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _exerciseControllers[index].length,
                          itemBuilder: (context, exerciseIndex) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _exerciseControllers[index]
                                        [exerciseIndex],
                                    decoration: InputDecoration(
                                      labelText:
                                          'Exercise ${exerciseIndex + 1}',
                                      suffixText: 'kg',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _exerciseControllers[index]
                                          .removeAt(exerciseIndex);
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          child: const Text('Add Exercise'),
                          onPressed: () {
                            setState(() {
                              _exerciseControllers[index]
                                  .add(TextEditingController());
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  child:
                      Text(widget.workout == null ? 'Create' : 'Save Changes'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      List<List<String>> exercises = [];
                      for (int i = 0; i < _exerciseControllers.length; i++) {
                        List<String> dayExercises = [];
                        for (int j = 0;
                            j < _exerciseControllers[i].length;
                            j++) {
                          dayExercises.add(_exerciseControllers[i][j].text);
                        }
                        exercises.add(dayExercises);
                      }
                      /**
                      Workout workout = Workout(
                        name: _nameController.text,
                        days: int.parse(_daysController.text),
                        exercises: exercises,
                      );
                       */
                      if (widget.workout == null) {
                        // Save new workout
                      } else {
                        // Update existing workout
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstText() => const Text(
        'Create a Workout',
        style: TextStyle(fontSize: 18),
      );
}


/**
class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _MyCreateSchedule();
}

class _MyCreateSchedule extends State<CreateSchedule> {
  //Text Input :
  TextEditingController nomeScheda = TextEditingController();
  TextEditingController numeroGiorni = TextEditingController();
  List<DaySchedule> giorniScheda = [];

  //Principal Widget :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Add Schedule'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            textWelcome(),
            const SizedBox(
              height: 8,
            ),
            textNome(),
            const SizedBox(
              height: 10.0,
            ),
            inputNome(),
            const SizedBox(
              height: 10.0,
            ),
            textNumeroGiorni(),
            const SizedBox(
              height: 10.0,
            ),
            inputNumeroGiorni(),
            const SizedBox(
              height: 20.0,
            ),
            buttonCompileSchedule(),
          ],
        ),
      ),
    );
  }

  //Other Widget :
  Widget textWelcome() => const Text(
        'Crea la tua scheda di allenamento',
        style: TextStyle(
          fontSize: 21,
        ),
      );

  Widget textNome() => const Text(
        'Nome Scheda',
        style: TextStyle(fontSize: 16.0),
      );

  Widget inputNome() => TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            hintText: 'Nome della Scheda',
            labelText: 'Nome *'),
        controller: nomeScheda,
      );

  Widget textNumeroGiorni() => const Text(
        'Numero giorni di allenamento',
        style: TextStyle(fontSize: 16.0),
      );

  Widget inputNumeroGiorni() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            filled: true,
            hintText: 'Numero Allenamenti',
            labelText: 'Numero *'),
        controller: numeroGiorni,
      );

  Widget buttonCompileSchedule() => ElevatedButton(
      onPressed: () => _showCompileForm(context),
      child: const Text('Compila Scheda'));

  //Methods for this Page :
  void _showCompileForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: CompileDaySchedule(_addFirstDataExpense),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addFirstDataExpense(DaySchedule daySchedule) {
    setState(() {
      giorniScheda.add(daySchedule);
    });
  }
}

 */