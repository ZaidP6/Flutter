import 'package:flutter/material.dart';
import 'package:star_what/models/people_response/people_response.dart';

class PeopleScreenWidget extends StatefulWidget {
  const PeopleScreenWidget({super.key});

  @override
  State<PeopleScreenWidget> createState() => _PeopleScreenWidgetState();
}

class _PeopleScreenWidgetState extends State<PeopleScreenWidget> {
  late Future<PeopleResponse> peopleResponse;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PeopleResponse>(
  future: peopleResponse,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return _buildPeopleList(snapshot.data!);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
)
  }

  Future<PeopleResponse> getPeople() async {
  final response = await http.get(Uri.parse('https://swapi.dev/api/people'));

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

  Widget _buildPeopleList(PeopleResponse peopleResponse) {}
  return ListView(
    children:
  )
}