import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_favourite.dart';
import 'package:gymapp/applications/Models/workout.dart';
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

  @override
  void initState() {
    super.initState();
    if (_boxFavourite.getAt(0)!.workoutList.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
    for (int i = 0; i < _boxFavourite.getAt(0)!.workoutList.length; i++) {
      print('WORKOUT $i DETAILS : ' +
          "\n Nome Workout : " +
          _boxFavourite.getAt(0)!.workoutList.elementAt(i).nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Favourite'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: !isEmpty
          ? AnimatedList(
              key: listKey,
              initialItemCount: _boxFavourite.getAt(0)!.workoutList.length,
              itemBuilder: (context, index, animation) => ListItemWidget(
                  workout: _boxFavourite.getAt(0)!.workoutList.elementAt(index),
                  animation: animation,
                  onClicked: () => _removeItem(
                      _boxFavourite.getAt(0)!.workoutList.elementAt(index),
                      index)))
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "You don't have any favourite Workout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        child: buildItem(),
      );

  Widget buildItem() => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 231, 229, 229)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
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
      );
}
