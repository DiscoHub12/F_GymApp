import 'package:flutter/material.dart';
import 'package:gymapp/applications/Data/boxes_account.dart';
// ignore: library_prefixes
import './applications/Utils/drawer.dart' as Drawer;
import 'applications/Utils/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MyApp();
}

class _MyApp extends State<App> {
  final boxAccount = BoxesAccount.getAccount();
  final _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        drawer: Drawer.NavigationDrawer(),
        body: SingleChildScrollView(
            child: Stack(children: [
          const SizedBox(
            height: 160,
            child: HeaderWidget(160, true),
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(boxAccount.getAt(0)!.nome,
                    style: const TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Text(
                  _date.day.toString(),
                  style: const TextStyle(
                    fontSize: 52,
                    color: Colors.black,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    _getMonth(_date.month),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                subtitle: Text(
                  _date.year.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ])));
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String _getMonth(int number) {
    String month = months.elementAt(number - 1);
    return month;
  }
}
