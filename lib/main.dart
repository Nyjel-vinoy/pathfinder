import 'package:flutter/material.dart';
import 'package:navmap/provider/map_provider.dart';
import 'package:navmap/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapProvider(), // Provide the MapProvider here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Indoor Navigation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
