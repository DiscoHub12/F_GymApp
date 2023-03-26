import 'package:flutter/material.dart';
import 'package:gymapp/applications/pages/home_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          HomePage(
            title: Text(
              'GYM SCHEDULE ',
              style: Theme.of(context) //
                  .primaryTextTheme
                  .titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
