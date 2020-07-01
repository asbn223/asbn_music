import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/add_in_screen.dart';
import 'package:musicplayer/screens/all_songs/all_songs_screen.dart';
import 'package:musicplayer/widgets/custom_drawer.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'components/clay_button.dart';

class NowPlayingScreen extends StatefulWidget {
  static String routeName = '/now_playing_screen';

  String songId;
  NowPlayingScreen({this.songId});

  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool isPlaylistOpened = false;
  final CountdownController countdownController = CountdownController();
  String status = 'hidden';

  @override
  void initState() {
    super.initState();

    //Set Notification to Pause and song will be paused
    MediaNotification.setListener('pause', () {
      setState(() => status = 'pause');
      Songs.pauseSong();
      countdownController.pause();
    });

    //Set Notification to Play and song will be played
    MediaNotification.setListener('play', () {
      setState(() => status = 'play');
      Songs.resumeSong();
      countdownController.resume();
    });

    //Song will be next after pressing next in notification
    MediaNotification.setListener('next', () {
      nextSong(id: widget.songId);
      countdownController.restart();
    });

    //Song will be previous after pressing next in notification
    MediaNotification.setListener('prev', () {
      if (int.parse(widget.songId) < 0) {
        // ignore: unnecessary_statements
        null;
      } else {
        prevSong(id: widget.songId);
        countdownController.restart();
      }
    });

    countdownController.restart();
  }

  //Convert to seconds
  int parseToSeconds(int ms) {
    Duration duration = Duration(milliseconds: ms);
    int seconds = (duration.inSeconds);
    return seconds;
  }

  //This method will play the next songs if pressed
  void nextSong({String id}) {
    if (id != null) {
      setState(() {
        widget.songId = (int.parse(id) + 1).toString();
      });
    }
    Songs songs = Provider.of(context, listen: false);
    Song song = songs.songs.firstWhere((song) => song.id == widget.songId);
    Songs.playSong(song.songFile);
    MediaNotification.showNotification(
      title: song.songName,
      author: song.artist,
      isPlaying: true,
    );
  }

  //This method will play the previous songs if pressed
  void prevSong({String id}) {
    if (id != null) {
      if (int.parse(id) < 0) {
        return;
      } else {
        setState(() {
          widget.songId = (int.parse(id) - 1).toString();
        });
      }
    }
    Songs songs = Provider.of(context, listen: false);
    Song song = songs.songs.firstWhere((song) => song.id == widget.songId);
    Songs.playSong(song.songFile);
    MediaNotification.showNotification(
      title: song.songName,
      author: song.artist,
      isPlaying: true,
    );
  }

  //This method will create container to show details of playing song
  Widget songDetailContainer({
    BuildContext context,
    Size size,
    String label,
    String songDetail,
  }) {
    return Flexible(
      child: NeuomorphicContainer(
        margin: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color.fromRGBO(209, 205, 199, 1.0),
              width: 2.0,
            ),
          ),
          width: ((size.width / 100) * 80),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      label + ": ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      songDetail.length > 20
                          ? songDetail.substring(0, 20)
                          : songDetail,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
        ),
        height: 50.0,
        borderRadius: BorderRadius.circular(10.0),
        border:
            Border.all(color: Color.fromRGBO(239, 238, 238, 1.0), width: 3.0),
        color: Theme.of(context).accentColor,
        style: NeuomorphicStyle.Flat,
        intensity: 0.2,
        offset: Offset(10.0, 10.0),
        blur: 7,
      ),
      flex: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Songs songs = Provider.of<Songs>(context, listen: false);
    Song song = songs.songs.firstWhere((music) => music.id == widget.songId);
    int songIndex = songs.songs.indexOf(song);

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                child: Stack(
                  children: <Widget>[
                    isPlaylistOpened
                        ? Text('')
                        : Positioned(
                            bottom: 140,
                            child: AnimatedContainer(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              duration: Duration(milliseconds: 750),
                              child: Text(
                                song.songName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Monoton',
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                    isPlaylistOpened
                        ? Text('')
                        : Positioned(
                            bottom: 115,
                            child: AnimatedContainer(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              duration: Duration(milliseconds: 750),
                              child: Countdown(
                                controller: countdownController,
                                seconds: parseToSeconds(
                                  int.parse(song.duration),
                                ),
                                build: (context, double time) {
                                  return Text(time.toString());
                                },
                                interval: Duration(milliseconds: 100),
                                onFinished: () {
                                  nextSong(id: song.id);
                                },
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 35,
                      left: 35,
                      child: ClayButton(
                        icon: Icons.skip_previous,
                        onPressed: () {
//                          songs.prevSong(songIndex - 1);
                          setState(() {
                            print(songIndex);
                            if (songIndex < 0) {
                              return;
                            }
                            widget.songId = songs.songs[songIndex - 1].id;
                            song = songs.songs.firstWhere(
                                (music) => music.id == widget.songId);
                            songIndex = songs.songs.indexOf(song);
                          });
                          countdownController.restart();
                          prevSong();
                        },
                        color: Color(0xFF4B4B4B),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      right: 35,
                      child: ClayButton(
                        icon: Icons.skip_next,
                        onPressed: () {
//                          songs.nextSong(songIndex + 1);
                          setState(() {
                            if (songIndex < 0 ||
                                songIndex > songs.songs.length) {
                              return;
                            }
                            widget.songId = songs.songs[songIndex + 1].id;
                            song = songs.songs.firstWhere(
                                (music) => music.id == widget.songId);
                            songIndex = songs.songs.indexOf(song);
                          });
                          countdownController.restart();
                          nextSong();
                        },
                        color: Color(0xFF4B4B4B),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    isPlaylistOpened
                        ? Text('')
                        : Positioned(
                            bottom: 35,
                            left: size.width / 3,
                            child: ClayButton(
                              icon: Icons.play_arrow,
                              onPressed: () {
                                Songs.resumeSong();
                                countdownController.resume();
                                MediaNotification.showNotification(
                                  title: song.songName,
                                  author: song.artist,
                                  isPlaying: true,
                                );
                              },
                              color: Color(0xFF4B4B4B),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                          ),
                    isPlaylistOpened
                        ? Text('')
                        : Positioned(
                            bottom: 35,
                            left: size.width / 1.8,
                            child: ClayButton(
                              icon: Icons.pause,
                              onPressed: () {
                                Songs.pauseSong();
                                countdownController.pause();
                                MediaNotification.showNotification(
                                  title: song.songName,
                                  author: song.artist,
                                  isPlaying: false,
                                );
                              },
                              color: Color(0xFF4B4B4B),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                          ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 750),
                      top: isPlaylistOpened ? 55 : 100,
                      left: isPlaylistOpened ? 95 : 45,
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              isPlaylistOpened ? 100 : 150),
                        ),
                        duration: Duration(milliseconds: 750),
                        width: isPlaylistOpened
                            ? size.width / 2
                            : size.width / 2 + 100,
                        height: isPlaylistOpened
                            ? size.height / 3.25
                            : size.height / 3.25 + 100,
                        child: ClayContainer(
                          depth: 50,
                          borderRadius: isPlaylistOpened ? 100 : 150,
                          emboss: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                isPlaylistOpened ? 100 : 150),
                            child: Hero(
                              tag: song.id,
                              child: Image.asset(
                                song.imgFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: 10,
                      top: isPlaylistOpened ? 115 : 15,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 750),
                      child: ClayButton(
                        icon: Icons.favorite_border,
                        onPressed: isPlaylistOpened ? null : null,
                        color: Color(0xFFFFBE76),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    AnimatedPositioned(
                      right: 10,
                      top: isPlaylistOpened ? 115 : 15,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 750),
                      child: ClayButton(
                        icon: Icons.playlist_add,
                        onPressed: isPlaylistOpened
                            ? () => Navigator.of(context).pushNamed(
                                AddInScreen.routeName,
                                arguments: song.id)
                            : null,
                        color: Color(0xFFFF7979),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    AnimatedPositioned(
                      left: isPlaylistOpened ? 75 : 10,
                      top: 15,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 750),
                      child: ClayButton(
                        icon: Icons.play_arrow,
                        onPressed: () {
                          Songs.resumeSong();
                          countdownController.resume();
                          MediaNotification.showNotification(
                            title: song.songName,
                            author: song.artist,
                            isPlaying: true,
                          );
                        },
                        color: Color(0xFF4B4B4B),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    AnimatedPositioned(
                      right: isPlaylistOpened ? 75 : 10,
                      top: 15,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 750),
                      child: ClayButton(
                        icon: Icons.pause,
                        onPressed: () {
                          Songs.pauseSong();
                          countdownController.pause();
                          MediaNotification.showNotification(
                            title: song.songName,
                            author: song.artist,
                            isPlaying: false,
                          );
                        },
                        color: Color(0xFF4B4B4B),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    AnimatedPositioned(
                      right: isPlaylistOpened ? 155 : 10,
                      top: isPlaylistOpened ? 0 : 15,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 750),
                      child: ClayButton(
                        icon: Icons.queue_music,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllSongsScreen(),
                            ),
                          );
                        },
                        color: Color(0xFF4B4B4B),
                        iconColor: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  width: double.infinity,
                  height: isPlaylistOpened ? size.height / 2 : 0,
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: <Widget>[
                      songDetailContainer(
                        context: context,
                        size: size,
                        label: "Song Name",
                        songDetail: song.songName,
                      ),
                      songDetailContainer(
                        context: context,
                        size: size,
                        label: "Artist",
                        songDetail: song.artist,
                      ),
                      songDetailContainer(
                        context: context,
                        size: size,
                        label: "Album",
                        songDetail: song.album,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: ClayButton(
                  icon: Icons.chevron_left,
                  onPressed: () => Navigator.pop(context, widget.songId),
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
        ),
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
    );
  }
}
