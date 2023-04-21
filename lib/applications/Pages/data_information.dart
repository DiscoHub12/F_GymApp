import 'package:flutter/material.dart';
import 'package:gymapp/applications/Pages/account_pages/account_pages.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
// ignore: library_prefixes
import '../Data/boxes_account.dart';
import '../Utils/costants.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class DataInfoPage extends StatefulWidget {
  const DataInfoPage({super.key});

  @override
  State<DataInfoPage> createState() => _MyDataInfoPage();
}

class _MyDataInfoPage extends State<DataInfoPage> {
  late final box = BoxesAccount.getAccount();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Information'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.report_gmailerrorred_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Report',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: kOtherColor,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: kBottomBorderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AccountPage()));
                    },
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(box.getAt(0)!.profileImage))),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${box.getAt(0)!.nome}  ${box.getAt(0)!.cognome}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(box.getAt(0)!.email,
                          style: Theme.of(context).textTheme.titleSmall),
                      Text(
                          'Registered on : ${getFormatDate(box.getAt(0)!.getDataIscrizione())}',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height - 350,
                width: 350,
                child: const Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Ciao'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Ciao'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String getFormatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kTextBlackColor,
                      fontSize: 7,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(value, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 35.0,
                child: Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: kTextBlackColor, fontSize: 7.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 92,
              child: Divider(
                thickness: 1.0,
              ),
            )
          ],
        ),
        Icon(
          Icons.lock_outline,
          size: 10.sp,
        ),
      ],
    );
  }
}

/**
 * Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              child: Text(
                username[0].toUpperCase(),
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Benvenuto, $username!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiche allenamenti",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Ultimo allenamento: $lastWorkout"),
                    Text("Ultima scheda utilizzata: $lastSchedule"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiche schede",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Numero di schede: $numSchede"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
 */
