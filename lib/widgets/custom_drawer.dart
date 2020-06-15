import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/custom_drawer_items.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isHomeSelected = true;

  bool isPlaylistsSelected = false;

  bool isSongsSelected = false;

  bool isSettingSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text("asbn2231@gmail.com"),
          accountName: Text("Sabin Nakarmi"),
        ),
        CustomDrawerItems(
          title: "Home",
          imageUrl: 'assets/icons/home.png',
          onTap: isHomeSelected
              ? null
              : () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                  setState(() {
                    isHomeSelected = true;
                    isPlaylistsSelected = false;
                    isSongsSelected = false;
                    isSettingSelected = false;
                  });
                },
        ),
        CustomDrawerItems(
          title: "Playlists",
          icon: Icons.playlist_play,
          color: Colors.blue,
          onTap: isPlaylistsSelected
              ? null
              : () {
                  setState(() {
                    isHomeSelected = false;
                    isPlaylistsSelected = true;
                    isSongsSelected = false;
                    isSettingSelected = false;
                  });
                },
        ),
        CustomDrawerItems(
          title: "Songs",
          icon: Icons.music_note,
          color: Colors.amber,
          onTap: isSongsSelected
              ? null
              : () {
                  setState(() {
                    isHomeSelected = false;
                    isPlaylistsSelected = false;
                    isSongsSelected = true;
                    isSettingSelected = false;
                  });
                },
        ),
        Divider(
          color: Color(0xFF808080),
          thickness: 1.5,
        ),
        CustomDrawerItems(
          title: "Settings",
          icon: Icons.settings,
          color: Colors.lightBlue,
          onTap: isSettingSelected
              ? null
              : () {
                  setState(() {
                    isHomeSelected = false;
                    isPlaylistsSelected = false;
                    isSongsSelected = false;
                    isSettingSelected = true;
                  });
                },
        ),
        CustomDrawerItems(
          title: "Log Out",
          icon: Icons.exit_to_app,
          color: Colors.purpleAccent,
        ),
        Divider(
          color: Color(0xFF808080),
          thickness: 1.5,
        ),
      ],
    );
  }
}
