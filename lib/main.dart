import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const SoundboardApp());
}

class SoundboardApp extends StatelessWidget {
  const SoundboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF05060A),
      ),
      home: const SoundboardScreen(),
    );
  }
}

class SoundClip {
  final String file;
  final String label;
  const SoundClip(this.file, this.label);
}

const List<SoundClip> _sounds = [
  SoundClip('sound7.mp3', 'GOLD'),
  SoundClip('sound4.mp3', 'LEPRECHAUN'),
  SoundClip('sound8.mp3', 'FLUET'),
  SoundClip('sound6.mp3', 'CRACKHEAD'),
  SoundClip('valdimir.mp3', 'THANKS VLAD'),
  SoundClip('hobnail.mp3', 'HOBNAIL BOOT'),
  SoundClip('crushedface.mp3', 'CRUSHED FACE'),
  SoundClip('sound35.mp3', 'BACON EGG CHEESE'),
  SoundClip('godblessyou.mp3', 'BLESS YOU'),
  SoundClip('sonofa.mp3', 'SON OF A..'),
  SoundClip('shitmind.mp3', 'SHIT MIND'),
  SoundClip('fightsong.mp3', 'FIGHT SONG'),
  SoundClip('do it.mp3', 'DO IT'),
  SoundClip('sound2.mp3', 'TOOLS'),
  SoundClip('sound10.mp3', 'WHISTLE TIPS'),
  SoundClip('sound11.mp3', 'WOO WOO'),
  SoundClip('sound12.mp3', 'DECORATION'),
  SoundClip('sound14.mp3', 'COLD POP'),
  SoundClip('sound15.mp3', 'ITS A FIRE'),
  SoundClip('sound16.mp3', 'AINT NOBODY'),
  SoundClip('sound17.mp3', 'BRONCHITIS'),
  SoundClip('sound18.mp3', 'LIMIT ON TALKING'),
  SoundClip('sound19.mp3', 'JOKES'),
  SoundClip('sound20.mp3', 'BOGGITY'),
  SoundClip('sound21.mp3', 'SIENFIELD'),
  SoundClip('sound22.mp3', 'AIR HORN'),
  SoundClip('sound23.mp3', 'PBJ TIME'),
  SoundClip('sound24.mp3', 'TURN DOWN'),
  SoundClip('sound25.mp3', 'GOING STREAKING'),
  SoundClip('sound26.mp3', 'GONG'),
  SoundClip('sound27.mp3', 'DIDDY DID'),
  SoundClip('sound28.mp3', 'GOOD MORNING VIETNAM'),
  SoundClip('sound29.mp3', 'NFL'),
  SoundClip('sound30.mp3', 'AT THIS MOMENT'),
  SoundClip('sound31.mp3', 'TRUMP COME'),
  SoundClip('sound32.mp3', 'WHAT THE HELL'),
  SoundClip('sound33.mp3', 'AIR HORN'),
  SoundClip('sound34.mp3', 'NEED \$\$'),
  SoundClip('sound35.mp3', 'BACON EGG CHEESE'),
  SoundClip('sound36.mp3', 'TRUMP SONG'),
  SoundClip('sound37.mp3', 'TRUMP COME'),
  SoundClip('sound38.mp3', 'EATING THE DOGS'),
  SoundClip('sound39.mp3', 'EATTING THE PETS'),
  SoundClip('sound42.mp3', 'LETS GET READY'),
  SoundClip('sound43.mp3', 'TRUMP ZELENSKY'),
];

const List<Color> _glowColors = [
  Color(0xFF00F0FF),
  Color(0xFFFF2EC4),
  Color(0xFF7C5CFF),
  Color(0xFFFFB800),
  Color(0xFF39FF88),
  Color(0xFFFF5252),
];

class SoundboardScreen extends StatefulWidget {
  const SoundboardScreen({super.key});

  @override
  State<SoundboardScreen> createState() => _SoundboardScreenState();
}

class _SoundboardScreenState extends State<SoundboardScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() => _playingIndex = null);
    });
  }

  Future<void> _onPadTap(int index) async {
    if (_playingIndex != null) {
      await _audioPlayer.stop();
      setState(() => _playingIndex = null);
      return;
    }
    setState(() => _playingIndex = index);
    await _audioPlayer.play(AssetSource('sounds/${_sounds[index].file}'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05060A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E17),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'DIGITAL SOUND BOARD',
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B93A8),
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: _sounds.length,
          itemBuilder: (context, index) {
            final glow = _glowColors[index % _glowColors.length];
            final isPlaying = _playingIndex == index;
            return _SoundPad(
              label: _sounds[index].label,
              glow: glow,
              isPlaying: isPlaying,
              onTap: () => _onPadTap(index),
            );
          },
        ),
      ),
    );
  }
}

class _SoundPad extends StatelessWidget {
  final String label;
  final Color glow;
  final bool isPlaying;
  final VoidCallback onTap;

  const _SoundPad({
    required this.label,
    required this.glow,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF11141F), Color(0xFF0B0E17)],
            ),
            border: Border.all(
              color: isPlaying ? glow : const Color(0xFF232838),
              width: 1,
            ),
            boxShadow: isPlaying
                ? [
                    BoxShadow(
                      color: glow.withValues(alpha: 0.55),
                      blurRadius: 22,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                right: 10,
                top: 8,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: glow.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(color: glow.withValues(alpha: 0.7), blurRadius: 6),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: Color(0xFFE8ECF7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
