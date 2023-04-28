import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
import 'package:rive/rive.dart';

import 'info_card.dart';
import '../app.dart';
import '../applications/Pages/account_pages/account_pages.dart';
import '../applications/Pages/chart_page.dart';
import '../applications/Pages/favourite_page.dart';
import '../applications/Pages/settings_pages/settings_pages.dart';
import '../applications/Pages/workout_pages/create_workout/create_workout_page.dart';
import '../applications/Pages/workout_pages/workout_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<StatefulWidget> createState() => _MySideMenu();
}

class _MySideMenu extends State<SideMenu> {
  final box = BoxesAccount.getAccount();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color.fromARGB(255, 255, 177, 61),
        child: SafeArea(
          child: Column(
            children: [
              buildHeader(context),
              //Here the icon is Rive asset
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const App()));
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
                      builder: (context) => const CreateWorkoutPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Chart'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChartPage()));
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
        ),
      ),
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
            AnimatedPositioned(
                height: 56,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 151, 30),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                duration: const Duration(milliseconds: 300)),
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
                    builder: (context) => const CreateWorkoutPage()));
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
