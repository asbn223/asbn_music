import 'package:floating_menu/floating_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/screens/home/components/home_body.dart';
import 'package:musicplayer/screens/now_playing3/now_playing_screen3.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //Fetch the user data from the database before building
    Provider.of<Users>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context, listen: false);
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
      //Multiple Floating Action Button.
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
            label: "See All",
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
              songs.shuffleSongs();
              final song = songs.shuffledSongs.first;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NowPlayingScreen3(
                    songId: song.id,
                  );
                }),
              );
              Songs.playSong(song.songFile);
              MediaNotification.showNotification(
                title: song.songName,
                author: song.artist,
                isPlaying: true,
              );
            },
          ),
        ],
      ),
//      bottomNavigationBar: BottomNav(),
    );
  }
}
