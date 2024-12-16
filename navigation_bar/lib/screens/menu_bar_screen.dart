import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Text('Instagram'),
    body: ,
    bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.search),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.add),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.favorite),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person),
      ),
    ]),
      
    );
  }
}