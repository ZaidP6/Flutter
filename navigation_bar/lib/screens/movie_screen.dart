import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true, 
      ),
      body: const Center(
        child: Text(
          'Movie Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}