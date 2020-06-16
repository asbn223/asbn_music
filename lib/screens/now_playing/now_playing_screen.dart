import 'package:flutter/material.dart';
import 'package:musicplayer/screens/now_playing/components/now_playing_body.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';

class NowPlayingScreen extends StatelessWidget {
  static String routeName = '/now_playing_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NowPlayingBody(),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
    );
  }
}
