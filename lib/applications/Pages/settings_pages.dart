import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/account.dart';
import 'package:gymapp/applications/Pages/account_pages.dart';
// ignore: library_prefixes
import '../../Other/image_string.dart';
import '../Utils/drawer.dart' as Drawer;
import '../Utils/settings_widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _MySettings();
}

class _MySettings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage(tProfileImage),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.create_outlined,
                            size: 20.0,
                            color: Colors.black,
                          )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Nome',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'Email',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccountPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              SettingsMenuWidget(
                  title: 'Settings', icon: Icons.settings, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Billing Details',
                  icon: Icons.settings,
                  onPress: () {}),
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
}
