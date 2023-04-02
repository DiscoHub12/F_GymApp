import 'package:flutter/material.dart';
import 'package:gymapp/applications/StoreData/boxes_workout.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _MyWoroutPage();
}

class _MyWoroutPage extends State<WorkoutPage> {
  final box = BoxesWorkout.getWorkout();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Workout'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
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
                        setState(() {
                          box.getAt(index)!.delete();
                        });
                      },
                    ),
                    onTap: () {
                      /**
                           * Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageModifyExpense(
                                      title: box
                                          .getAt(index)!
                                          .nameTotalExpense,
                                      totalExpense: box.getAt(index)!, index: index,)));
                           */
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
}
