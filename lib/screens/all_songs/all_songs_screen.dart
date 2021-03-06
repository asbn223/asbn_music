import 'package:flutter/material.dart';
import 'package:musicplayer/screens/all_songs/components/all_songs_body.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';
import 'package:musicplayer/widgets/search/search_items.dart';

class AllSongsScreen extends StatelessWidget {
  static String routeName = '/all_songs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Songs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchItems(),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      body: AllSongsBody(),
    );
  }
}
