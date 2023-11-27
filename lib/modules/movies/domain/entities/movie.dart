import 'dart:convert';

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String name;
  final String id;

  Movie({required this.name, required this.id});

  factory Movie.fromMap(Map map) {
    return Movie(id: map["id"], name: map["name"]);
  }
  factory Movie.fromJson(String rawMovie) {
    final movieMap = jsonDecode(rawMovie);
    return Movie(
      name: movieMap['name'],
      id: movieMap['id'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  String toString() {
    return toJson();
  }

  @override
  List<Object?> get props => [id, name];
}
