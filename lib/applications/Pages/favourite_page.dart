import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_favourite.dart';
import 'package:gymapp/applications/Models/workout.dart';
import 'package:gymapp/applications/Pages/workout_pages/inside_workout_page.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class FavouriteWorkoutPage extends StatefulWidget {
  const FavouriteWorkoutPage({super.key});

  @override
  State<FavouriteWorkoutPage> createState() => _MyFavouriteWorkoutPage();
}

class _MyFavouriteWorkoutPage extends State<FavouriteWorkoutPage> {
  bool isEmpty = false;
  final listKey = GlobalKey<AnimatedListState>();

  final _boxFavourite = BoxesFavourite.getWorkout();

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  void initState() {
    super.initState();
    if (_boxFavourite.getAt(0)!.workoutList.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    for (int i = 0; i < _boxFavourite.getAt(0)!.workoutList.length; i++) {
      //print('WORKOUT $i DETAILS : ' +
      // "\n Nome Workout : " +
      //_boxFavourite.getAt(0)!.workoutList.elementAt(i).nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Favourite'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: !isEmpty
          ? SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.90,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.90, // Aggiunta dell'altezza al widget contenitore
                  child: ListView.builder(
                    itemCount: _boxFavourite.getAt(0)!.workoutList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_boxFavourite
                              .getAt(0)!
                              .workoutList
                              .elementAt(index)
                              .nome),
                          subtitle: Text(
                            '${_boxFavourite.getAt(0)!.workoutList.elementAt(index).giorni.toString()} days',
                          ),
                          trailing: GestureDetector(
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: () {
                              setState(() {
                                _removeItem(
                                  _boxFavourite
                                      .getAt(0)!
                                      .workoutList
                                      .elementAt(index),
                                  index,
                                );
                              });
                              setState(() {});
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsideWorkoutPage(
                                  workout: _boxFavourite
                                      .getAt(0)!
                                      .workoutList
                                      .elementAt(index),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Any Favourite Workout',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  //Metodo del Widget:
  void _removeItem(Workout workout, int index) async {
    _boxFavourite.getAt(0)!.deleteWorkoutFavourite(workout);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ListItemWidget(
              workout: workout,
              animation: animation,
              onClicked: () {},
            ),
        duration: const Duration(milliseconds: 600));
  }
}

class ListItemWidget extends StatelessWidget {
  final Workout workout;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget(
      {required this.workout,
      required this.animation,
      required this.onClicked,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeIn)),
        child: buildItem(context),
      );

  Widget buildItem(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InsideWorkoutPage(
                    workout: workout,
                  )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 12,
          margin: const EdgeInsets.all(13),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: Text(
              workout.nome,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            subtitle: Text('Total day : ${workout.giorni}'),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
