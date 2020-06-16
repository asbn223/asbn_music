import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/components/bottom_songs_list.dart';
import 'package:provider/provider.dart';

class BottomContainerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context).songs;
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: songs[index],
          child: BottomSongsList(),
        );
      },
    );
  }
}

//ListView.builder(itemBuilder: (context, index){
//ClayContainer(
//
//)
//});
