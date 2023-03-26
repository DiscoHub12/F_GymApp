import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({required this.title, super.key});

  final Widget title;

  @override
  State<HomePage> createState() => _MyHomePage();
  
}

class _MyHomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return [
                const PopupMenuItem(child: Text('Schede'))
              ]; 
            }),
          Expanded(
            child: widget.title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}