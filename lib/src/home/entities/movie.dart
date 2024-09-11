import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.name,
    required this.director,
  });

  final int id;
  final String name;
  final String director;

  Movie copyWith({
    int? id,
    String? name,
    String? director,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      director: director ?? this.director,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      director: json["director"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "director": director,
      };

  @override
  String toString() {
    return "$id, $name, $director, ";
  }

  @override
  List<Object?> get props => [
        id,
        name,
        director,
      ];
}
