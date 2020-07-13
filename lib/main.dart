import 'dart:io';

import 'package:flare_splash_screen/flare_splash_screen.dart' as SS;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/setting_provider.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/add_in_screen.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/login/login_screen.dart';
import 'package:musicplayer/screens/playlist/playlist_screen.dart';
import 'package:musicplayer/screens/profile/profile_screen.dart';
import 'package:musicplayer/screens/register/register_screen.dart';
import 'package:musicplayer/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider<Settings>(
          create: (_) => Settings(),
        ),
      ],
      child: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (BuildContext context, Settings settings, Widget child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Music Player",
          theme: ThemeData.light().copyWith(
              primaryColor: Color(0xFF341F97), accentColor: Color(0xFFFAB1A0)),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(color: Colors.black),
            textTheme: TextTheme(
              caption: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            ),
            accentColor: Color(0xFFFAB1A0),
          ),
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
          routes: {
            AddInScreen.routeName: (context) => AddInScreen(),
            AllSongsScreen.routeName: (context) => AllSongsScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            PlaylistScreen.routeName: (context) => PlaylistScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
//          SongListScreen.routeName: (context) => SongListScreen(),
//          NowPlayingScreen.routeName: (context) => NowPlayingScreen(),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = true;
  bool isLoggedIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      checkLogin();
    }
    isInit = false;
  }

  void checkLogin() async {
    isLoggedIn = await Provider.of<Users>(context, listen: false).autoLogin();
    await Provider.of<Settings>(context, listen: false).fetchDarkMode();
    await Provider.of<Users>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height / 2,
              width: double.infinity,
              color: Color(0xFF08315E),
              child: Image.asset(
                'assets/resources/logo2.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height / 2,
                width: double.infinity,
                child: SS.SplashScreen.navigate(
                  name: 'assets/Loading.flr',
                  backgroundColor: Color(0xFF08315E),
//                  fit: BoxFit.cover,
                  width: double.infinity,
                  startAnimation: 'Alarm',
                  loopAnimation: 'Alarm',
                  until: () => Future.delayed(
                    Duration(seconds: 3),
                  ),
                  alignment: Alignment.center,
                  next: (_) => isLoggedIn ? HomeScreen() : LoginScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
