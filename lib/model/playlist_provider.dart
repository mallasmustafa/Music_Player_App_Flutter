import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/model/song.dart';

class PlayListProvider extends ChangeNotifier {
  //playlist of song
  final List<Song> _playList = [
    Song(
      songName: "So Sick",
      artistName: "Neyo",
      albumArtImagePath: "assets/images/1.jpg",
      audioPath: "audio/chill.mp3",
    ),
    //song2
    Song(
      songName: "Acid Repo",
      artistName: "chance the rapper",
      albumArtImagePath: "assets/images/2.jpg",
      audioPath: "audio/chill2.mp3",
    ),
    //song 3
    Song(
      songName: "Pheonix",
      artistName: "ASAP Rocky",
      albumArtImagePath: "assets/images/3.webp",
      audioPath: "audio/chill3.mp3",
    ),
  ];
  // A U D I O P L A Y E R S
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constractor
  PlayListProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play song
  void play() async {
    try {
    final String path = _playList[_currentSongIndex!].audioPath;
   //final String path = 'audio/chill.mp3';
    await _audioPlayer.stop(); // stop the current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  } catch (e) {
    print('Error in play(): $e');
    // Handle the error appropriately
  }
  }

  //pause song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause and rusme
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to  a specific position in a current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() async {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        //go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if it's last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    //if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
      //if it's within first 2 second of the song, go to previous song
    } else {
      if (_currentDuration.inSeconds > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's first song loop back to last song
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((neWDuration) {
      _totalDuration = neWDuration;
      notifyListeners();
    });
    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for completed song
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  //current song playing index
  int? _currentSongIndex;

  //Getter
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setter
  set currentSongIndex(int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); //play the song at the new index
    }
    notifyListeners();
  }
}
