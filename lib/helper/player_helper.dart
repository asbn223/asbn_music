import 'package:assets_audio_player/assets_audio_player.dart';

class PlayerHelper {
  static AssetsAudioPlayer aap = AssetsAudioPlayer();

  static bool isPlaying = false;
  static void openSong({
    String songFile,
    String id,
    String songName,
    String artist,
    String album,
  }) {
    aap.stop();
    aap.open(
      Audio.file(
        songFile,
        metas: Metas(
          id: id,
          title: songName,
          artist: artist,
          album: album,
        ),
      ),
      showNotification: true,
    );
    isPlaying = true;
  }

  static void playPauseSong() {
    if (isPlaying) {
      aap.pause();
      isPlaying = false;
    } else {
      aap.play();
      isPlaying = true;
    }
  }

  void nextSong(String fileName, int index) {}
}
