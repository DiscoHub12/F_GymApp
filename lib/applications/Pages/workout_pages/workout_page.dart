import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_workout.dart';
import 'package:gymapp/applications/Pages/create_workout/create_workout_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/inside_workout_page.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _MyWoroutPage();
}

class _MyWoroutPage extends State<WorkoutPage> {
  bool isEmpty = false;

  final box = BoxesWorkout.getWorkout();

  @override
  void initState() {
    super.initState();
    if (box.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Workout'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: !isEmpty
          ? SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(box.getAt(index)!.nome),
                        subtitle: Text('Giorni : ${box.getAt(index)!.giorni}'),
                        trailing: GestureDetector(
                          child: const Icon(Icons.delete, color: Colors.red),
                          onTap: () {
                            _dialogNumberExercise(
                                context, index, box.getAt(index)!.nome);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InsideWorkout(
                                        workout: box.getAt(index)!,
                                      )));
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: Text(
                    "You don't have any Workout",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCreateSchedule()));
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Icon(Icons.create))
              ],
            ),
    );
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
                  box.getAt(index)!.delete();
                  Navigator.pop(context);
                }),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );

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
}
