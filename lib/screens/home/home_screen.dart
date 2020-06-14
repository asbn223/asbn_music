import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/home/components/home_body.dart';
import 'package:musicplayer/widgets/bottom_nav.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Music",
                    style: GoogleFonts.getFont('Cairo'),
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
          body: FutureBuilder(
            future: Provider.of<Songs>(context, listen: false).getSongs(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return HomeBody();
              }
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
