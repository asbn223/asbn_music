import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/play_queue/play_queue_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music Player",
      theme: ThemeData(
        primaryColor: Color(0xFF341F97),
        accentColor: Color(0xFFF1F2F6),
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        PlayQueueScreen.routeName: (context) => PlayQueueScreen(),
      },
    );
  }
}
