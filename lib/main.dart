import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musicplayer/helper/save_file.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/add_in_screen.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/playlist/playlist_screen.dart';
import 'package:musicplayer/screens/song_list/song_list_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      SaveFile.dir = directory;
      SaveFile.jsonFile = new File(SaveFile.dir.path + "/" + SaveFile.fileName);
      SaveFile.fileExits = SaveFile.jsonFile.existsSync();
      if (SaveFile.fileExits) {
        setState(() {
          SaveFile.fileContent =
              json.decode(SaveFile.jsonFile.readAsStringSync());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Songs(),
        ),
        ChangeNotifierProvider(
          create: (_) => Playlists(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Music Player",
        theme: ThemeData(
          primaryColor: Color(0xFF341F97),
          accentColor: Color(0xFFFAB1A0),
        ),
        home: HomeScreen(),
        routes: {
          AddInScreen.routeName: (context) => AddInScreen(),
          AllSongsScreen.routeName: (context) => AllSongsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          PlaylistScreen.routeName: (context) => PlaylistScreen(),
          SongListScreen.routeName: (context) => SongListScreen(),
//          NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
        },
      ),
    );
  }
}
