import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/favourites/fav_screen.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/login/login_screen.dart';
import 'package:musicplayer/screens/playlist/playlist_screen.dart';
import 'package:musicplayer/screens/profile/profile_screen.dart';
import 'package:musicplayer/screens/settings/settings_screen.dart';
import 'package:musicplayer/widgets/custom_drawer_items.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProfileScreen.routeName),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(
                File(user.user[0].imgFile),
              ),
            ),
          ),
          accountEmail: Text(user.user[0].email),
          accountName: Text(user.user[0].name),
        ),
        CustomDrawerItems(
          title: "Home",
          imageUrl: 'assets/icons/home.png',
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
        CustomDrawerItems(
          title: "Playlists",
          icon: Icons.playlist_play,
          color: Colors.blue,
          onTap: () {
            Navigator.pushNamed(context, PlaylistScreen.routeName);
          },
        ),
        CustomDrawerItems(
          title: "Songs",
          icon: Icons.music_note,
          color: Colors.amber,
          onTap: () => Navigator.pushNamed(context, AllSongsScreen.routeName),
        ),
        CustomDrawerItems(
          title: "Favourites",
          icon: Icons.favorite,
          color: Colors.red,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavScreen(),
            ),
          ),
        ),
        Divider(
          color: Color(0xFF808080),
          thickness: 1.5,
        ),
        CustomDrawerItems(
          title: "Settings",
          icon: Icons.settings,
          color: Colors.lightBlue,
          onTap: () => Navigator.pushNamed(context, SettingsScreen.routeName),
        ),
        CustomDrawerItems(
            title: "Log Out",
            icon: Icons.exit_to_app,
            color: Colors.purpleAccent,
            onTap: () {
              user.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }),
        Divider(
          color: Color(0xFF808080),
          thickness: 1.5,
        ),
      ],
    );
  }
}
