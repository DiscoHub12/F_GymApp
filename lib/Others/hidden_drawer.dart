import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:gymapp/applications/Models/FileAdapter/file_adapter.dart';
import 'package:gymapp/applications/Pages/account_pages/account_pages.dart';
import 'package:gymapp/applications/Pages/chart_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/create_workout/create_workout_page.dart';
import 'package:gymapp/applications/Pages/workout_pages/workout_page.dart';
import 'package:gymapp/applications/Pages/settings_pages/settings_pages.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../applications/Pages/favourite_page.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _MyHiddenDrawer();
}

class _MyHiddenDrawer extends State<HiddenDrawer> {
  late final box = BoxesAccount.getAccount();
  final FileAdapter fileImage = FileAdapter();

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Home',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const App()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Workout',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const WorkoutPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'New Workout',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const CreateWorkoutPage(firstWorkout: false,)),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Chart',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const ChartPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Favourite',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const FavouriteWorkoutPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Account',
            baseStyle: const TextStyle(),
            selectedStyle: const TextStyle(),
          ),
          const AccountPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 255, 179, 65),
      screens: _pages,
      initPositionSelected: 0,
      styleAutoTittleName: const TextStyle(color: Colors.white),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.orange,
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AccountPage()));
              },
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(box.getAt(0)!.profileImage))),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              box.getAt(0)!.nome,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              box.getAt(0)!.email,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const App()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Workout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WorkoutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('New Workout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateWorkoutPage(firstWorkout: false,)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Chart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChartPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favourite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavouriteWorkoutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_rounded),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AccountPage()));
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()));
              },
            ),
          ],
        ),
      );
}
