import 'package:flutter/material.dart';
import 'package:music_player_app/components/neu_box.dart';
import 'package:music_player_app/model/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  //convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      //get playlist
      final playList = value.playList;
      //get current song index
      final currentSong = playList[value.currentSongIndex ?? 0];
      //ui
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("P L A Y L I S T"),
          backgroundColor: Colors.grey,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeuBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(currentSong.albumArtImagePath),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                currentSong.songName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(currentSong.artistName),
                            ],
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //start time
                    Text(formatTime(value.currentDuration)),
                    //shuffle time
                    const Icon(Icons.shuffle),
                    //repeat time
                    const Icon(Icons.repeat),
                    //end time
                    Text(formatTime(value.totalDuration))
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0),
                ),
                child: Slider(
                  min: 0,
                  max: value.totalDuration.inSeconds.toDouble(),
                  value: value.currentDuration.inSeconds.toDouble(),
                  activeColor: Colors.green,
                  onChanged: (double double) {
                    //during when the user is sliding around
                  },
                  onChangeEnd: (double double) {
                    //sliding is finished, go to that position in song duration
                    value.seek(Duration(seconds: double.toInt()));
                  },
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  //play previous song
                  button(Icons.skip_previous, value.playPreviousSong),
                  const SizedBox(width: 20),
                  //play pause
                  button(
                    value.isPlaying ? Icons.pause : Icons.play_arrow,
                    value.pauseOrResume,
                    flex: 2,
                  ),
                  //skip forward
                  const SizedBox(width: 20),
                  button(Icons.skip_next, value.playNextSong),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget button(IconData icon, Function()? onTap, {int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: onTap,
        child: NeuBox(
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}
