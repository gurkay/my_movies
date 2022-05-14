import 'package:flutter/material.dart';

import 'constants/constants_color.dart';
import 'routes/route_generator.dart';
import 'screens/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filmler',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.deepPurple,
        primaryTextTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'Raleway',
            color: cHeadSearchColor,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          headline2: TextStyle(
              fontFamily: 'Raleway',
              color: cHeadSearchColor,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          headline3: TextStyle(
            color: cPrimaryTextColor,
            fontSize: 28,
          ),
          headline4: TextStyle(
            fontFamily: 'Abay',
            color: cTextIconsColor,
            fontSize: 28,
          ),
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            color: cSecondaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          subtitle2: TextStyle(
            fontFamily: 'OpenSans',
            color: cSecondaryTextColor,
            fontSize: 14,
          ),
        ),
      ),
      initialRoute: ScreenHome.routeName,
      routes: {
        ScreenHome.routeName: (context) => const ScreenHome(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
