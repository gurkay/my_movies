import 'package:http/http.dart';

class Movie {
  int? id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  dynamic voteAverage;

  Movie(
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
  );

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
    releaseDate = parsedJson['release_date'];
    title = parsedJson['title'];
    voteAverage = parsedJson['vote_average'];
  }
}
