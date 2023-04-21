import 'package:flutter/material.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;
import '../account_pages/account_pages.dart';
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
}
