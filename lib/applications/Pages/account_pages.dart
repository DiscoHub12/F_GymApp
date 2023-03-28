import 'package:flutter/material.dart';
import 'package:gymapp/Other/image_string.dart';
// ignore: library_prefixes
import '../Utils/drawer.dart' as Drawer;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _MyAccount();
}

class _MyAccount extends State<Account> {



  @override
  Widget build(BuildContext context) {
    var isDard = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 120, height: 120,
                child: ClipRRect( borderRadius: BorderRadius.circular(100), child : Image(image: AssetImage(tProfileImage),),),
              ), 
              const SizedBox(height: 20,), 
              Text('Nome', style: Theme.of(context).textTheme.headline4,),
              Text('Email',style: Theme.of(context).textTheme.bodySmall,), 
              const SizedBox(height: 20,), 
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, side: BorderSide.none, shape: const StadiumBorder(),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.black),),
                ),
              ), 
              const SizedBox(height: 20,),
              const Divider(),
              const SizedBox(height: 10,),
              ListTile(
                leading: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), 
                    color: Colors.yellow.withOpacity(0.1), 
                  ),
                  child: Icon(Icons.settings, color: Colors.black,),

                ),
                title: Text('Settings', style: Theme.of(context).textTheme.bodyMedium,),
              )

            ],
          ),
        ),
      ),
    );
  }
}
