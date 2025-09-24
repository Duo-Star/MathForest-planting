import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class Mambo {
  BuildContext context;
  String name;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;

  Mambo(this.context, this.name);

  Future<bool> ha(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name: $message'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: _isMuted ? '开音效' : '闭嘴！',
          onPressed: () => toggleMute(),
        ),
      ),
    );

    if (!_isMuted) {
      await _playSound();
    }

    return true;
  }

  Future<void> _playSound() async {
    try {
      // 方法1：直接使用AssetSource
      await _audioPlayer.play(AssetSource('sounds/mambo.mp3'));
    } catch (e) {
      print('播放音效失败: $e');
      // 如果失败，尝试备用方案
      await _playFallbackSound();
    }
  }

  Future<void> _playFallbackSound() async {
    try {
      // 方法2：使用系统声音作为备用
      SystemSound.play(SystemSoundType.click);
    } catch (e) {
      print('备用音效也失败: $e');
    }
  }

  void toggleMute() => _isMuted = !_isMuted;
  void dispose() => _audioPlayer.dispose();
}