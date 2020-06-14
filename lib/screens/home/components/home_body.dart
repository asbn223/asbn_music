import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/home/components/music_container.dart';
import 'package:musicplayer/screens/home/components/songs_list.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context).songs;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: ListView(
        children: <Widget>[
          Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                itemCount: songs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: songs[index],
                    child: SongsList(),
                  );
                },
              )),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            child: Text(
              "Recently Played",
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 325,
            width: double.infinity,
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.5 / 2),
              children: <Widget>[
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            child: Text(
              "Newly Added",
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 475,
            width: double.infinity,
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.5 / 2),
              children: <Widget>[
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
                MusicContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
