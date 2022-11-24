// To parse this JSON data, do
//
//     final genresModel = genresModelFromJson(jsonString);

import 'dart:convert';

GenresModel genresModelFromJson(String str) =>
    GenresModel.fromJson(json.decode(str));

String genresModelToJson(GenresModel data) => json.encode(data.toJson());

class GenresModel {
  GenresModel({this.genres, this.message});

  List<Genre>? genres;
  String? message;

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
      genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      message: "message");

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
        "message": message
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
