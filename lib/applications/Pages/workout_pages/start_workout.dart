import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_day_schedule.dart';
// ignore: library_prefixes
import '../../Models/day_schedule.dart';
import 'package:gymapp/app.dart';

class StartWorkoutPage extends StatefulWidget {
  const StartWorkoutPage({super.key, required this.daySchedule});

  final DaySchedule daySchedule;

  @override
  State<StartWorkoutPage> createState() => _MyStartWorkoutPage();
}

class _MyStartWorkoutPage extends State<StartWorkoutPage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _result = '00:00:00';
  bool _paused = true;
  final boxSchedule = BoxesDaySchedule.getDaySchedule();
  final TextEditingController _newWeight = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paused = false;
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(widget.daySchedule.muscoliAllenati),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: () {
                _saveLastUsage();
              },
            )
          ],
          automaticallyImplyLeading: false),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Start Workout",
                style: TextStyle(fontSize: 16),
              ),
              _buildTimerUI(),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: widget.daySchedule.esercizi.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(widget.daySchedule.esercizi
                                  .elementAt(index)
                                  .nomeEsercizio),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(widget.daySchedule.esercizi
                                      .elementAt(index)
                                      .ripetizioni),
                                  const SizedBox(
                                    width: 35.0,
                                  ),
                                  Text(
                                      '${widget.daySchedule.esercizi.elementAt(index).peso.toString()} kg')
                                ],
                              ),
                              onLongPress: () {
                                _dialogNewWeight(context, index);
                              },
                            ),
                          );
                        },
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerUI() => SizedBox(
        width: 300,
        child: Column(
          children: <Widget>[
            Text(
              _result,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    onPressed: () => setState(() {
                          if (_paused) {
                            _start();
                          } else {
                            _stop();
                          }
                        }),
                    icon: Icon(_paused ? Icons.play_arrow : Icons.pause)),
                IconButton(
                    onPressed: () => setState(() {
                          _reset();
                        }),
                    icon: const Icon(Icons.stop))
              ],
            )
          ],
        ),
      );

  Widget _requestNewWeight(BuildContext context, index) => Container(
        padding: const EdgeInsets.all(8),
        height: 200,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Set new Weight',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _newWeight,
                decoration: const InputDecoration(
                  labelText: 'New Weight',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  setNewWeight(index);

                  Navigator.pop(context);
                  setState(() {});
                }),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );

  void _dialogNewWeight(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestNewWeight(context, index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        _result =
            '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });
    _paused = false;
    _stopwatch.start();
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
    _paused = true;
  }

  void _reset() {
    _stop();
    _stopwatch.reset();
    _result = '00:00:00';
    setState(() {});
  }

  void _saveLastUsage() {
    for (int i = 0; i < boxSchedule.length; i++) {
      DaySchedule tmp = boxSchedule.getAt(i)!;
      if (tmp == widget.daySchedule) {
        boxSchedule.getAt(i)!.setLastUsage(DateTime.now());
      }
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const App()));
  }

  void setNewWeight(int indexEsercizio) {
    for (int i = 0; i < boxSchedule.length; i++) {
      DaySchedule tmp = boxSchedule.getAt(i)!;
      if (tmp == widget.daySchedule) {
        print("Trovato");
      }
    }
    /**
    for (int i = 0; i < boxWorkout.length; i++) {
      Workout tmp = boxWorkout.getAt(i)!;

      for (int j = 0; j < tmp.listaGiorni.length; j++) {
        DaySchedule tmp1 = tmp.listaGiorni.elementAt(j);

        if (tmp1 == widget.daySchedule ||
            tmp1.esercizi.contains(widget.daySchedule.esercizi.elementAt(indexEsercizio))) {
          var exercise =
              boxExercise.get(tmp1.esercizi.elementAt(indexEsercizio));

          if (exercise != null) {
            exercise.setPeso(double.parse(_newWeight.text));
            exercise.save();
          }
        }
      }
    }
     */
    setState(() {});
  }
}
