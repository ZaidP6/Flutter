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
        title: const Text('Star Wars Characters'),
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
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://www.example.com/character-image.png' ??
                            'https://starwars-visualguide.com/assets/img/big-placeholder.jpg', // Asegúrate de poner la URL de la imagen
                      ),
                    ),
                    title: Text(character.name ?? 'Desconocido'),
                    subtitle: Text('Height: ${character.height} cm'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Aquí puedes agregar lógica para redirigir o mostrar detalles
                    },
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
