import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context, listen: false).songs;

    return Container();
  }
}
