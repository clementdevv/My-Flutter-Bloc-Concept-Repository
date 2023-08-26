import 'package:flutter/material.dart';

import 'features/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLoc',
      home: const Home(),
      theme: ThemeData(
        accentColor: Colors.green,
        primaryColor: Colors.redAccent,
      ),
    );
  }
}
