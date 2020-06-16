import 'package:flutter/material.dart';
import 'package:musicplayer/screens/now_playing/components/clay_button.dart';
import 'package:musicplayer/screens/now_playing/components/top_container_body.dart';

class NowPlayingBody extends StatefulWidget {
  @override
  _NowPlayingBodyState createState() => _NowPlayingBodyState();
}

class _NowPlayingBodyState extends State<NowPlayingBody> {
  bool isPlaylistOpened = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Theme.of(context).accentColor,
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            width: double.infinity,
            height: isPlaylistOpened ? size.height / 2 : size.height,
//            color: Colors.green,
            duration: Duration(milliseconds: 750),
            curve: Curves.easeInOut,
            child: TopContainerBody(
              isOpened: isPlaylistOpened,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              width: double.infinity,
              height: isPlaylistOpened ? size.height / 2 : 0,
              color: Colors.purpleAccent,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeInOut,
            ),
          ),
          Positioned(
            left: 10,
            top: 15,
            child: ClayButton(
              icon: Icons.chevron_left,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            right: 10,
            top: 15,
            child: ClayButton(
              icon: Icons.menu,
              onPressed: () {
                setState(() {
                  isPlaylistOpened = !isPlaylistOpened;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
