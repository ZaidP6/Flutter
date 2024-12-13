import 'package:flutter/material.dart';
import 'package:starwars_app/models/people_response/people_response.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:starwars_app/models/people_response/result.dart';
import 'package:starwars_app/screens/people_detail_screen.dart';

class PeopleHologramScreen extends StatefulWidget {
  const PeopleHologramScreen({super.key});

  @override
  State<PeopleHologramScreen> createState() => _PeopleHologramScreenState();
}

class _PeopleHologramScreenState extends State<PeopleHologramScreen> {
  late Future<PeopleResponse> peopleList;

  @override
  void initState() {
    super.initState();
    peopleList = fetchCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personajes Star Wars',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Stack(
        children: [
          // Fondo de estrellas que ocupa toda la pantalla
          const StarField(),
          // Contenido principal con las tarjetas
          FutureBuilder<PeopleResponse>(
            future: peopleList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (context, index) {
                    var character = snapshot.data!.results![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 255, 136, 0), width: 3),
                          borderRadius: BorderRadius.circular(12.0),
                          color: const Color.fromARGB(255, 0, 0, 0), 
                        ),
                        height: 120,
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 8 / 11,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'https://starwars-visualguide.com/assets/img/big-placeholder.jpg',
                                  image:
                                      'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg',    
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (character.name ?? 'Desconocido')
                                          .toUpperCase(),
                                          maxLines: 1,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 8,
                                            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Future<PeopleResponse> fetchCharacter() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people/'));

    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load character data');
    }
  }
}

// Widget para simular el fondo de estrellas
class StarField extends StatelessWidget {
  const StarField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, 
      height: MediaQuery.of(context).size.height,  
      color: Colors.black,
      child: CustomPaint(
        painter: StarPainter(),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill;

    
    for (int i = 0; i < 200; i++) {  
      double x = Random().nextDouble() * size.width;
      double y = Random().nextDouble() * size.height;
      double radius = Random().nextDouble() * 2.0 + 1.0;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  Widget _buildPeopleList(BuildContext context, PeopleResponse peopleResponse) {
    return ListView.builder(
        itemCount: peopleResponse.results!.length,
        itemBuilder: (context, index) {
          return _buildPeopleItem(context, peopleResponse.results![index]);
        });
  }

  Widget _buildPeopleItem(BuildContext context, People people) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PeopleDetailScreen(peopleItem: people)
            ),
          );
        },
        child: Text(people.name!));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


