import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/custom_drawer_items.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
        CustomDrawerItems(
            title: "Playlists",
            icon: Icons.playlist_play,
            color: Colors.blue,
            onTap: null,),
        CustomDrawerItems(
            title: "Songs",
            icon: Icons.music_note,
            color: Colors.amber,
            onTap: null,),
        Divider(
          color: Color(0xFF808080),
          thickness: 1.5,
        ),
        CustomDrawerItems(
            title: "Settings",
            icon: Icons.settings,
            color: Colors.lightBlue,
            onTap: null,),
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
