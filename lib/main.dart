import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_previewer/screens/homepage.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('darkMode');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('darkMode').listenable(),
        builder: (context, Box box, child) {
          bool getModeValue = box.get('darkMode', defaultValue: true);
          return MaterialApp(
            title: 'Movie Parade',
            themeMode: getModeValue ? ThemeMode.light : ThemeMode.dark,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(),
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
