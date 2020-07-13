import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchSuggestions extends StatelessWidget {
  final String query;
  final String songName;
  final ValueChanged<String> onSelected;
  SearchSuggestions({
    this.query,
    this.songName,
    this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(FontAwesomeIcons.music),
      title: RichText(
        text: TextSpan(
          text: songName.substring(0, query.length),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: songName.substring(query.length),
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      onTap: () {
        onSelected(songName);
      },
    );
  }
}
