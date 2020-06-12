import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home/components/home_body.dart';
import 'package:musicplayer/widgets/bottom_nav.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Music",
                  textAlign: TextAlign.center,
                ),
                background: Image.asset(
                  'assets/resources/music_logo.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ];
        },
        body: HomeBody(),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
