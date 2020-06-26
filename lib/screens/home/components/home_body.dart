import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/home/components/songs_list.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: FutureBuilder(
        future: songs.getSongs(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                )
              : GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5 / 1.8,
                  ),
                  itemCount:
                      songs.songs.length > 100 ? 100 : songs.songs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value: songs.songs[index],
                      child: SongsList(),
                    );
                  },
                );
        },
      ),
    );
  }
}
