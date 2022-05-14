import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_movies/components/menu_drawer_list.dart';
import 'package:my_movies/models/argument.dart';
import 'package:my_movies/models/movie.dart';
import 'package:my_movies/models/tv.dart';

import '../screens/screen_movie_detail.dart';
import '../services/http_helper.dart';

class ScreenMovieList extends StatefulWidget {
  static String routeName = '/screen_movie_list';
  final String screen;
  const ScreenMovieList({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  State<ScreenMovieList> createState() => _ScreenMovieListState();
}

class _ScreenMovieListState extends State<ScreenMovieList> {
  String? result;
  String _title = 'Yükleniyor...';
  String? _tvMovie;
  HttpHelper? helper;

  int? moviesCount;
  int? tvCount;
  List? movies;
  List? tv;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Yükleniyor...');

  @override
  void initState() {
    helper = HttpHelper();
    init();
    super.initState();
  }

  Future init() async {
    switch (widget.screen) {
      case 'upcoming':
        movies = [];
        movies = await helper!.getUpcoming();

        setState(() {
          moviesCount = movies!.length;
          movies = movies;
          _title = 'Yakında Gelecek Filmler';
          _tvMovie = 'movie';
          searchBar = Text(_title);
        });
        break;
      case 'popular':
        movies = [];
        movies = await helper!.getPopular();

        setState(() {
          moviesCount = movies!.length;
          movies = movies;
          _title = 'Popüler Filmler';
          _tvMovie = 'movie';
          searchBar = Text(_title);
        });
        break;
      case 'tvPopular':
        tv = [];
        tv = await helper!.getTvPopular();

        setState(() {
          moviesCount = tv!.length;
          tv = tv;
          _title = 'Popüler Diziler';
          _tvMovie = 'tv';
          searchBar = Text(_title);
        });
        break;
      default:
    }
  }

  Future search(text) async {
    movies = await helper!.findMovies(text);
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  Future searchTv(text) async {
    tv = await helper!.findTv(text);
    setState(() {
      moviesCount = tv!.length;
      tv = tv;
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerItem = MenuDrawerList();
    NetworkImage image;
    return Scaffold(
      drawer: Drawer(
        child: drawerItem,
      ),
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              if (visibleIcon.icon == Icons.search) {
                setState(() {
                  visibleIcon = Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String text) {
                      if (_tvMovie == 'tv') {
                        searchTv(text);
                      } else {
                        search(text);
                      }
                    },
                    style: Theme.of(context).primaryTextTheme.headline1,
                    textAlign: TextAlign.center,
                  );
                });
              } else {
                setState(() {
                  visibleIcon = const Icon(Icons.search);
                  searchBar = Text(
                    _title,
                    style: Theme.of(context).primaryTextTheme.headline2,
                    textAlign: TextAlign.center,
                  );
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: (BuildContext context, int position) {
          switch (_tvMovie) {
            case 'movie':
              if (movies![position].posterPath != null) {
                image = NetworkImage(iconBase + movies![position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              break;
            case 'tv':
              if (tv![position].posterPath != null) {
                image = NetworkImage(iconBase + tv![position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              break;
            default:
              image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: (_tvMovie == 'movie')
                  ? Text(movies![position].title)
                  : Text(tv![position].name),
              subtitle: (_tvMovie == 'movie')
                  ? Text(
                      'Tarih: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(movies![position].releaseDate))}  IMDB: ${movies![position].voteAverage.toString()}',
                    )
                  : Text(
                      'Tarih: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(tv![position].firstAirDate))}  IMDB: ${tv![position].voteAverage.toString()}',
                    ),
              onTap: () {
                if (_tvMovie == 'movie') {
                  Navigator.pushNamed(
                    context,
                    ScreenMovieDetail.routeName,
                    arguments: Argument(
                      movies![position],
                      Tv(null, null, null, null, null, null),
                    ),
                  );
                }
                if (_tvMovie == 'tv') {
                  Navigator.pushNamed(
                    context,
                    ScreenMovieDetail.routeName,
                    arguments: Argument(
                      Movie(null, null, null, null, null, null),
                      tv![position],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
