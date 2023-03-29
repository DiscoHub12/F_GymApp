import 'package:flutter/material.dart';
import 'package:gymapp/applications/Pages/account_pages/modify_account_pages.dart';
// ignore: library_prefixes
import '../../Utils/drawer.dart' as Drawer;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('Assets/imageProfile.png')),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              _containerInformation('Nome', 'Il Mio nomme', Icons.person),
              const SizedBox(
                height: 15,
              ),
              _containerInformation('Email', 'La mia email', Icons.person),
              const SizedBox(
                height: 15,
              ),
              _containerInformation('Eta', 'La mia Eta', Icons.date_range),
              const SizedBox(
                height: 15,
              ),
              _buttonModify(),
            ],
          ),
        ),
      ),
    );
  }

  //Widget for this clas:
  Widget _containerInformation(String nomeInfo, String nome, icon) => Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 162, 79),
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

  Widget _buttonModify() => ElevatedButton.icon(
        label: const Text('Modify'),
        icon: const Icon(Icons.update),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ModifyAccount()));
        },
      );
}
