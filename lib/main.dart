import 'package:flutter/material.dart';
import 'package:movie_previewer/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Parade',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
