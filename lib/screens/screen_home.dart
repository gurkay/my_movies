import 'package:flutter/material.dart';

import '../screens/screen_movie_list.dart';

class ScreenHome extends StatefulWidget {
  static String routeName = '/';
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return const ScreenMovieList(
      screen: 'upcoming',
    );
  }
}
