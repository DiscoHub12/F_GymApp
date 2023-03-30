import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;
import '../account_pages/account_pages.dart';
import 'settings_widget.dart';

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
        centerTitle: true,
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
                        image: AssetImage('Assets/imageProfile.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Nome',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Email',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsMenuWidget(
                  title: 'Account',
                  icon: Icons.account_box_rounded,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccountPage()));
                  }),
              SettingsMenuWidget(
                  title: 'Languages', icon: Icons.settings, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Privacy', icon: Icons.language, onPress: () {}),
              SettingsMenuWidget(
                  title: 'FeedBack', icon: Icons.privacy_tip, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Licenses', icon: Icons.feedback, onPress: () {}),
              SettingsMenuWidget(
                  title: 'Information', icon: Icons.info, onPress: () {}),
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

  //Widget for this clas:
  Widget _containerInformation(String nomeInfo, String nome, icon) => Container(
        height: 60,
        width: 400,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 212, 205),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(icon),
            ),
            Text(
              nomeInfo,
              style: const TextStyle(fontSize: 19),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  nome,
                  style: const TextStyle(fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      );
}
