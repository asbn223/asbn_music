import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Songs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Music Player",
        theme: ThemeData(
          primaryColor: Color(0xFF341F97),
          accentColor: Color(0xFFFAB1A0),
        ),
        home: HomeScreen(),
        routes: {
          AllSongsScreen.routeName: (context) => AllSongsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
        },
      ),
    );
  }
}
