import 'dart:convert';

import 'result.dart';

class PeopleResponse {
  int? count;
  String? next;
  dynamic previous;
  List<People>? results;

  PeopleResponse({this.count, this.next, this.previous, this.results});

  factory PeopleResponse.fromMap(Map<String, dynamic> data) {
    return PeopleResponse(
      count: data['count'] as int?,
      next: data['next'] as String?,
      previous: data['previous'] as dynamic,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => People.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results?.map((e) => e.toMap()).toList(),
      };

  factory PeopleResponse.fromJson(String data) {
    return PeopleResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
