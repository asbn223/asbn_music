import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/widgets/search/search_result.dart';
import 'package:musicplayer/widgets/search/search_suggestions.dart';
import 'package:provider/provider.dart';

class SearchItems extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
//Actions for the app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
//Leading Icons on the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final songData = Provider.of<Songs>(context, listen: false).songs;
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: songData[index],
        child: SearchResult(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final song = Provider.of<Songs>(context, listen: false)
        .songs
        .where((element) =>
            element.songName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: song[index],
          child: SearchSuggestions(
            query: this.query,
            songName: song[index].songName,
            onSelected: (String suggestion) {
              this.query = suggestion;
              showResults(context);
            },
          ),
        );
      },
      itemCount: song.length,
    );
  }
}
