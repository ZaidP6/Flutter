import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/home_screen.dart';
import 'package:navigation_bar/screens/movie_screen.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _selectedIndex = 0; 

  final List<Widget> _pages = <Widget>[
    const Home(),
    const Movie(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true, 
      ),
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped, 
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey, 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: '',
          ),
        ],
      ),
    );
  }
}
