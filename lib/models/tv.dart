import 'package:http/http.dart';

class Tv {
  String? firstAirDate;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  dynamic voteAverage;

  Tv(
    this.firstAirDate,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.voteAverage,
  );

  Tv.fromJson(Map<String, dynamic> parsedJson) {
    firstAirDate = parsedJson['first_air_date'];
    id = parsedJson['id'];
    name = parsedJson['name'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
    voteAverage = parsedJson['vote_average'];
  }
}
