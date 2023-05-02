import 'package:flutter/material.dart';

class TestUI extends StatefulWidget {
  const TestUI({super.key});

  @override
  State<TestUI> createState() => _MyTestUIPage();
}

class _MyTestUIPage extends State<TestUI> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          Positioned(
              right: -getSmallDiameter(context) / 3,
              top: -getSmallDiameter(context) / 3,
              child: Container(
                width: getSmallDiameter(context),
                height: getSmallDiameter(context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 168, 37),
                          Color.fromARGB(255, 253, 192, 101),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              )),
          Positioned(
              left: -getBigDiameter(context) / 3.5,
              top: -getBigDiameter(context) / 3.5,
              child: Container(
                width: getBigDiameter(context),
                height: getBigDiameter(context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Color.fromARGB(255, 255, 181, 70),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: const Center(
                  child: Text('Hello'),
                ),
              )),
        ],
      ),
    );
  }
}
