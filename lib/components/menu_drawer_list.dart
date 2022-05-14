import 'package:flutter/material.dart';
import 'package:my_movies/screens/screen_movie_list.dart';

import '../screens/screen_home.dart';

class MenuDrawerList extends StatelessWidget {
  MenuDrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/icons/app_logo.png',
          height: 42.0,
        ),
      ),
      accountName: const Text('Filmler'),
      accountEmail: const Text('İletişim: kucukdunya03@gmail.com'),
    );
    return ListView(
      children: [
        drawerHeader,
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Yakında Gelecek Filmler'),
          onTap: () {
            Navigator.pushNamed(
              context,
              ScreenMovieList.routeName,
              arguments: 'upcoming',
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.podcasts),
          title: const Text('Popüler Filmler'),
          onTap: () {
            Navigator.pushNamed(
              context,
              ScreenMovieList.routeName,
              arguments: 'popular',
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Popüler Diziler'),
          onTap: () {
            Navigator.pushNamed(
              context,
              ScreenMovieList.routeName,
              arguments: 'tvPopular',
            );
          },
        ),
      ],
    );
  }
}
