import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/all_songs/components/all_songs_items.dart';
import 'package:provider/provider.dart';

class AllSongsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songs = Provider.of<Songs>(context, listen: false).songs;
    return Container(
      height: size.height,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ChangeNotifierProvider.value(
            value: songs[index],
            child: AllSongsItems(),
          );
        },
        itemCount: songs.length,
      ),
    );
  }
}
