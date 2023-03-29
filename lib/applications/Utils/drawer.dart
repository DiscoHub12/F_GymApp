import 'package:flutter/material.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/applications/Pages/account_pages/account_pages.dart';
import 'package:gymapp/applications/Pages/chart_page.dart';
import 'package:gymapp/applications/Pages/create_schedule_page.dart';
import 'package:gymapp/applications/Pages/schedule_page.dart';
import 'package:gymapp/applications/Pages/settings_pages/settings_pages.dart';

import '../Pages/favourite_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.orange,
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('Assets/imageProfile.png'),
              
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Name',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: 16, color: Colors.white),
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const App()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Schedule()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateSchedule()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Graphics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChartSchedule()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favourite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavouriteSchedule()));
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.account_box_rounded),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AccountPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Settings()));
              },
            ),
          ],
        ),
      );
}
