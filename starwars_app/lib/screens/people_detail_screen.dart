import 'package:flutter/material.dart';
import 'package:starwars_app/models/people_response/result.dart';


class PeopleDetailScreen extends StatefulWidget {
  final People peopleItem;
  const PeopleDetailScreen({super.key, required this.peopleItem});

  @override
  State<PeopleDetailScreen> createState() => _PeopleDetailScreenState();
}

class _PeopleDetailScreenState extends State<PeopleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.peopleItem.name!),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}