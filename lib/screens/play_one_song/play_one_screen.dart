import 'package:flutter/material.dart';
import 'package:musicplayer/screens/play_one_song/components/play_one_body.dart';

class PlayOneScreen extends StatelessWidget {
  static String routeName = 'play_one_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PlayOneBody(),
      ),
    );
  }
}
