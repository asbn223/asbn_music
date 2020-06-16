import 'package:floating_menu/floating_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/components/home_body.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Music",
          style: GoogleFonts.getFont('Cairo'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      body: SafeArea(
        child: HomeBody(),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      floatingActionButton: FloatingMenu(
        isMainButton: true,
        mainButtonColor: Colors.red,
        mainButtonIcon: Icons.queue_music,
        mainButtonShape: BoxShape.circle,
        floatingType: FloatingType.RightCurve,
        floatingButtonShape: BoxShape.circle,
        floatingButtons: [
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 70,
            shape: BoxShape.circle,
            color: Colors.deepOrange,
            label: "Audio",
            icon: Icons.audiotrack,
            size: Size(45, 45),
            onPress: () {
              Navigator.of(context).pushNamed(AllSongsScreen.routeName);
            },
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 130,
            shape: BoxShape.circle,
            color: Colors.grey,
            label: "File",
            icon: Icons.shuffle,
            size: Size(45, 45),
            onPress: () {
              print("File");
            },
          ),
        ],
      ),
//      bottomNavigationBar: BottomNav(),
    );
  }
}
