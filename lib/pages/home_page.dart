import 'package:flutter/material.dart';
import 'package:music_player_app/components/my_drawer.dart';
import 'package:music_player_app/model/playlist_provider.dart';
import 'package:music_player_app/model/song.dart';
import 'package:music_player_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late final dynamic playlistProvider;
  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  //go to song
  void goToSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;
    //navigator to song page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          //get the playlist
          final List<Song> playList = value.playList;
          //return list view ui
          return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              //Get the individual song of index
              final Song song = playList[index];
              //return list tile ui
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(
                  song.albumArtImagePath,
                  height: 200,
                  width: 100,
                ),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
