import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_exercise.dart';
// ignore: library_prefixes
import '../../Models/day_schedule.dart';
import '../../Models/exercise.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({super.key, required this.daySchedule});

  final DaySchedule daySchedule;

  @override
  State<StartWorkout> createState() => _MyStartWorkout();
}

class _MyStartWorkout extends State<StartWorkout> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _result = '00:00:00';
  bool _paused = true;

  final TextEditingController _newWeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.daySchedule.muscoliAllenati),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: const <Widget>[],
      ),
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

  Widget _requestRemoving(BuildContext context, index) => Container(
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
                  widget.daySchedule.esercizi
                      .elementAt(index)
                      .setPeso(double.parse(_newWeight.text));
                  widget.daySchedule.esercizi.elementAt(index).save();

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
            content: _requestRemoving(context, index),
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
}
