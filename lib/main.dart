import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(SoundboardApp());
}

class SoundboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundboard',
      theme: ThemeData.dark(),
      home: SoundboardScreen(),
    );
  }
}

class SoundboardScreen extends StatefulWidget {
  @override
  _SoundboardScreenState createState() => _SoundboardScreenState();
}

class _SoundboardScreenState extends State<SoundboardScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _sounds = List.generate(25, (index) => 'assets/sound${index + 1}.mp3');

  void _playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Soundboard")),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _sounds.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () => _playSound(_sounds[index]),
            child: Text("Sound ${index + 1}"),
          );
        },
      ),
    );
  }
}
