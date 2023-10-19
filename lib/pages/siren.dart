import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class Siren extends StatefulWidget {
  const Siren({super.key});

  @override
  State<Siren> createState() => _SirenState();
}

class _SirenState extends State<Siren> {
  late Timer _timer;
  bool _shouldPlaySong = false;

  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  // Future<void> _playSong() async {
  //   // Load the song asset from the file system
  //   final assetData = await _loadAsset('assets/siren.mp3');
  //   // Play the song using your preferred audio player plugin
  //   // For example: https://pub.dev/packages/audioplayers
  // }

  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse('http://home-sec.onrender.com/api'));
    final jsonData = json.decode(response.body);
    print(jsonData.toString());
    final shouldPlaySong = jsonData['bell'] == "1";

    setState(() {
      _shouldPlaySong = shouldPlaySong;
    });

    if (_shouldPlaySong) {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/siren.mp3"),
        autoStart: true,
        // autoPlay: true,
        showNotification: true,
      );
      // await _playSong();
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (_) => _fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siren Alert'),
      ),
      body: Center(
        child: Text(
          _shouldPlaySong ? 'Alarm activated' : 'Alarm Deactivated',
        ),
      ),
    );
  }
}
