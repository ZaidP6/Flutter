import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starwars_app/models/people_response/result.dart';

class StarWarsService {
  final String baseUrl = 'https://swapi.dev/api/';

  Future<List<People>> fetchCharacters() async {
    final response = await http.get(Uri.parse('${baseUrl}people/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => People.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
