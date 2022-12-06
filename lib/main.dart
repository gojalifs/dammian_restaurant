import 'package:dammian_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';

import 'pages/detail_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.grey.shade300,
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          labelMedium: TextStyle(color: Colors.black54, fontSize: 18),
          // subtitle1: const TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
            restaurant:
                ModalRoute.of(context)!.settings.arguments as Restaurant),
      },
    );
  }
}
