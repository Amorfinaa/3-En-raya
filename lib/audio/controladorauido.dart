import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final AudioController _instance = AudioController._internal();
  factory AudioController() => _instance;

  AudioController._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isMusicPlaying = false;

  bool get isMusicPlaying => _isMusicPlaying;

  Future<void> init() async {
    // En audioplayers no hace falta inicializar nada especial
    print('AudioController listo con audioplayers');
  }

  Future<void> toggleMusic() async {
    if (_isMusicPlaying) {
      await stopMusic();
    } else {
      await playMusic();
    }
  }

  Future<void> playMusic() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop); // música en loop
      await _player.play(
        AssetSource('music/sayo.mp3'), // carpeta assets/music/sayo.mp3
        volume: 0.5,
      );
      _isMusicPlaying = true;
      print('Música reproduciéndose');
    } catch (e) {
      print('Error al reproducir música: $e');
    }
  }

  Future<void> stopMusic() async {
    try {
      await _player.stop();
      _isMusicPlaying = false;
      print('Música detenida');
    } catch (e) {
      print('Error al detener música: $e');
    }
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
