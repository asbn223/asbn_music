import 'package:flutter/material.dart';
import 'package:musicplayer/screens/all_songs/components/all_songs_body.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';

class AllSongsScreen extends StatelessWidget {
  static String routeName = '/all_songs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Songs'),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      body: AllSongsBody(),
    );
  }
}
