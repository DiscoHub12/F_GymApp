import 'package:flutter/material.dart';
import 'package:gymapp/applications/Pages/workout_pages/workout_page.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;
import 'settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _MySettingsPage();
}

class _MySettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsMenuWidget(
                  title: 'Languages',
                  icon: Icons.settings,
                  onPress: () {
                    _dialogNumberExercise(context);
                  }),
              SettingsMenuWidget(
                  title: 'Privacy', icon: Icons.language, onPress: () {}),
              SettingsMenuWidget(
                  title: 'FeedBack', icon: Icons.privacy_tip, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Licenses', icon: Icons.feedback, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Information', icon: Icons.info, onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WorkoutPage()));
                  }),
              const Divider(color: Colors.black),
              SettingsMenuWidget(
                  title: 'Quit',
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _requestLanguages(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        height: 140,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Change Language',
                style: TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 29,
                        backgroundImage: AssetImage('Assets/italian.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 29,
                        backgroundImage:
                            AssetImage('Assets/icon-english-10.png'),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      );

  void _dialogNumberExercise(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: _requestLanguages(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }
}
