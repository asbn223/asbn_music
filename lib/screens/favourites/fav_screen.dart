import 'package:flutter/material.dart';
import 'package:musicplayer/screens/favourites/components/fav_body.dart';
import 'package:musicplayer/widgets/search/search_items.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
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
      body: FavBody(),
    );
  }
}
