import 'package:audio_helper/audio_helper.dart';
import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../interfaces/iquestion_viewmodel.dart';

class QuestionViewModel extends ChangeNotifier implements IQuestionViewModel {
  final String _correctSoundPath = 'sounds/correct.mp3';
  final String _failSoundPath = 'sounds/fail.mp3';
  final soundEffect = BetterSoundEffect();
  int correctSoundId;
  int failedSoundId;

  Future<void> _checkCorrect() async {
    AudioHelper.stopMusic();
    if (true) {
      Get.dialog(
          Container(
            color: Colors.transparent,
            child: Image.asset('assets/images/bingo.png'),
          ),
          transitionDuration: const Duration(seconds: 1),
          transitionCurve: Curves.easeInOutCirc);
      await soundEffect.play(correctSoundId);
      await Future.delayed(const Duration(seconds: 5), () {
        Get.back();
        Get.back();
      });
    } else {
      Get.dialog(
          Container(
            color: Colors.transparent,
            child: Image.asset('assets/images/failed.png'),
          ),
          transitionDuration: const Duration(seconds: 1),
          transitionCurve: Curves.easeInOutCirc);
      await soundEffect.play(failedSoundId);
      await Future.delayed(const Duration(seconds: 5), () {
        clearAll();
        Get.back();
      });
    }
    clearAll();
    AudioHelper.playMusic();
  }

  Future<void> initSound() async {
    correctSoundId =
        await soundEffect.loadAssetAudioFile("assets/sounds/correct.wav");
    failedSoundId =
        await soundEffect.loadAssetAudioFile("assets/sounds/fail.wav");
  }

  @override
  Future<void> init() async {
    await initSound();

    notifyListeners();
  }

  @override
  void clearAll() {
    notifyListeners();
  }

  @override
  set setCorrectAnswer(String correctAnswer) {
    notifyListeners();
  }
}
