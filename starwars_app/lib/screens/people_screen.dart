import 'package:flutter/material.dart';
import 'package:starwars_app/models/people_response/people_response.dart';
import 'package:http/http.dart' as http;

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
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
          'Star Wars Characters',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: FutureBuilder<PeopleResponse>(
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 8 / 11,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                    'https://starwars-visualguide.com/assets/img/big-placeholder.jpg',
                                image:
                                    'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20.0),
                            padding: EdgeInsets.all(5.0),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Title(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    child: Text(
                                      (character.name ?? 'Desconocido')
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )),
                                Row(
                                  //lista peliculas en las que sale (la imagen de la peli)
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Aquí puedes añadir las imágenes de las películas
                                    Icon(Icons.movie, size: 40),
                                    Icon(Icons.movie, size: 40),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<PeopleResponse> fetchCharacter() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PeopleResponse.fromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}


/*
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
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://www.example.com/character-image.png' ??
                            'https://starwars-visualguide.com/assets/img/big-placeholder.jpg',
                      ),
                    ),
                    title: Text(character.name ?? 'Desconocido'),
                    subtitle: Text('Height: ${character.height} cm'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      //Ir a detalles
                    },
                  ),
                );
              },
            );
          }
*/
