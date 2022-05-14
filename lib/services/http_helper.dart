import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/movie.dart';
import '../models/tv.dart';

class HttpHelper {
  final String urlKey = 'api_key=224d3a48fc65587506361d1c5cd6a2b7';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlBaseTv = 'https://api.themoviedb.org/3/tv';
  final String urlUpcoming = '/upcoming?';
  final String urlDay = '/day?';
  final String urlPopular = '/popular?';
  final String urlLanguage = '&language=tr-TR';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=224d3a48fc65587506361d1c5cd6a2b7&query=';
  final String urlSearchBaseTv =
      'https://api.themoviedb.org/3/search/tv?api_key=224d3a48fc65587506361d1c5cd6a2b7&query=';

  Future<List?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies =
          moviesMap.map((element) => Movie.fromJson(element)).toList();
      return movies;
    } else {
      return throw Exception('Failed to load movie');
    }
  }

  Future<List?> getPopular() async {
    final String popular = urlBase + urlPopular + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(popular));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies =
          moviesMap.map((element) => Movie.fromJson(element)).toList();
      return movies;
    } else {
      return throw Exception('Failed to load movie');
    }
  }

  Future<List?> getTvPopular() async {
    final String popular = urlBaseTv + urlPopular + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(popular));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final tvMap = jsonResponse['results'];
      List tv = tvMap.map((element) => Tv.fromJson(element)).toList();
      return tv;
    } else {
      return throw Exception('Failed to load movie');
    }
  }

  Future<List?> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies =
          moviesMap.map((element) => Movie.fromJson(element)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List?> findTv(String title) async {
    final String query = urlSearchBaseTv + title;
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final tvMap = jsonResponse['results'];
      List tv = tvMap.map((element) => Tv.fromJson(element)).toList();
      return tv;
    } else {
      return null;
    }
  }
}
