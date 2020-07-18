import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/setting_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settings';

  Widget label(String labelText) {
    return Container(
      height: 25,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            labelText,
            style: GoogleFonts.getFont(
              "Poppins",
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, Playlists playlists, String email) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Do you really want to delete all the playlists?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: () {
                  playlists.deleteAllPlaylist(email: email);
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final playlists = Provider.of<Playlists>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    label("Appearence"),
                    ListTile(
                      title: Text("Light Mode"),
                      trailing: Container(
                        height: 100,
                        width: 75,
                        child: InkWell(
                          child: FlareActor(
                            'assets/switch_daytime.flr',
                            animation: settings.isDarkMode
                                ? 'switch_night'
                                : 'switch_day',
                            fit: BoxFit.contain,
                          ),
                          onTap: () => settings.toggleDarkMode(),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Color(0xFF808080),
                    ),
                    label("Playlist"),
                    ListTile(
                      title: Text("Delete All Playlist"),
                      onTap: () => _showDialog(
                        context,
                        playlists,
                        user.user[0].email,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Color(0xFF808080),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
