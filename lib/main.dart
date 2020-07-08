import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/add_in_screen.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/playlist/playlist_screen.dart';
import 'package:musicplayer/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Songs>(
          create: (_) => Songs(),
        ),
        ChangeNotifierProvider<Playlists>(
          create: (_) => Playlists(),
        ),
        ChangeNotifierProvider<Users>(
          create: (_) => Users(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Music Player",
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                appBarTheme: AppBarTheme(color: Colors.black),
                textTheme: TextTheme(
                  body1: TextStyle(color: Colors.black),
                  caption: TextStyle(color: Colors.white),
                ),
                accentColor: Color(0xFFFAB1A0),
              )
            : ThemeData(
                primaryColor: Color(0xFF341F97),
                accentColor: Color(0xFFFAB1A0),
              ),
        home: HomeScreen(),
        routes: {
          AddInScreen.routeName: (context) => AddInScreen(),
          AllSongsScreen.routeName: (context) => AllSongsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          PlaylistScreen.routeName: (context) => PlaylistScreen(),
          SettingsScreen.routeName: (context) =>
              SettingsScreen(isDarkMode, toggleDarkMode),
//          SongListScreen.routeName: (context) => SongListScreen(),
//          NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
        },
      ),
    );
  }
}
