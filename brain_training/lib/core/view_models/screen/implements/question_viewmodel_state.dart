import 'package:audio_helper/audio_helper.dart';
import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:math';
import '../../../../widgets/dialog.dart';
import '../interfaces/iquestion_viewmodel.dart';

class QuestionViewModel extends ChangeNotifier implements IQuestionViewModel {
  final String _correctSoundPath = 'sounds/correct.wav';
  final String _failSoundPath = 'sounds/fail.wav';
  final soundEffect = BetterSoundEffect();
  var rng = Random();
  int correctSoundId;
  int failedSoundId;
  String _curnentCalculation = '';
  int _curnentScore = 0;
  bool _answer = true;
  CountdownController _countdownController;
  @override
  setCountdownController(CountdownController controller) {
    _countdownController = controller;
    notifyListeners();
  }

  @override
  // TODO: implement curnentCalculation
  String get curnentCalculation => _curnentCalculation;
  @override
  // TODO: implement curnentScore
  int get curnentScore => _curnentScore;

  @override
  Future<void> checkAnswer(bool answer) async {
    //AudioHelper.stopMusic();
    if (answer == _answer) {
      await soundEffect.play(correctSoundId);
      _curnentScore++;
      _genData();
    } else {
      await soundEffect.play(failedSoundId);
      _countdownController.pause();
      Get.dialog(
        GemDialog(
          onBack: () {
            _playing = false;
            clearAll();
            Get.back();
          },
        ),
        barrierDismissible: false,
      );
    }
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
    _countdownController.pause();
  }

  void _genData() {
    if (_curnentScore != 0 && _curnentScore % 10 == 0) _level++;
    _answer = rng.nextBool();
    switch (rng.nextInt(_level < 2 ? 2 : 4)) {
      case 0:
        summation();
        break;
      case 1:
        subtraction();
        break;
      case 2:
        multiplication();
        break;
      case 3:
        division();
        break;
    }
    notifyListeners();
    _countdownController.restart();
  }

  void clearAll() {
    _curnentScore = 0;
    _level = 1;
    notifyListeners();
  }

  @override
  set setCorrectAnswer(String correctAnswer) {
    notifyListeners();
  }

  void summation() {
    int x = rng.nextInt(10 + _level * 5) + 1;
    int y = rng.nextInt(10 + _level * 5) + 1;
    int z = x + y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 + _level * 2) + 1)
          : (z -= rng.nextInt(5 + _level * 2) + 1);
    }
    _curnentCalculation = '$x + $y = $z';
  }

  void subtraction() {
    int x = rng.nextInt(10 + _level * 5) + 1;
    int y = rng.nextInt(10 + _level * 5) + 1;
    int z = x - y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 + _level * 2) + 1)
          : (z -= rng.nextInt(5 + _level * 2) + 1);
    }
    _curnentCalculation = '$x - $y = $z';
  }

  void multiplication() {
    int x = rng.nextInt(5 + _level * 2) + 1;
    int y = rng.nextInt(5 + _level * 2) + 1;
    int z = x * y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(2 + _level) + 1)
          : (z -= rng.nextInt(2 + _level) + 1);
    }
    _curnentCalculation = '$x x $y = $z';
  }

  void division() {
    int x = rng.nextInt(5 + _level * 2) + 1;
    int y = rng.nextInt(5 + _level * 2) + 1;
    int z = x * y;
    if (!_answer) {
      rng.nextBool()
          ? (x += rng.nextInt(1 + _level) + 1)
          : (x -= rng.nextInt(1 + _level) + 1);
    }
    _curnentCalculation = '$z ÷ $y = $x';
  }

  @override
  Future<void> timeOut() async {
    await soundEffect.play(failedSoundId);
    Get.dialog(
      GemDialog(
        onBack: () {
          _playing = false;
          clearAll();
          Get.back();
          notifyListeners();
        },
      ),
      barrierDismissible: false,
    );
    // Get.defaultDialog(
    //   title: 'Time Out!!!',
    //   middleText: '',
    //   confirm: TextButton(
    //     onPressed: () {
    //       Get.back();
    //       _genData();
    //     },
    //     child: Text('Chơi lại'),
    //   ),
    //   barrierDismissible: false,
    // );
  }

  int _level = 1;
  @override
  // TODO: implement level
  int get level => _level;

  bool _playing = false;
  @override
  bool get playing => _playing;
  @override
  set setPlaying(bool playing) {
    _playing = playing;
    clearAll();
    _genData();
    notifyListeners();
  }

  bool _musicOn = true;
  @override
  bool get musicOn => _musicOn;

  @override
  set setMusic(bool musicOn) {
    _musicOn = musicOn;
    musicOn ? AudioHelper.playMusic() : AudioHelper.stopMusic();
    notifyListeners();
  }
}
