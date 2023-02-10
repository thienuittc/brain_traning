import 'package:audio_helper/audio_helper.dart';
import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:math';
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
      Get.defaultDialog(
        title: 'Thua rồi TT',
        middleText: '',
        confirm: TextButton(
          onPressed: () {
            Get.back();
            clearAll();
            _genData();
          },
          child: Text('Chơi lại'),
        ),
        barrierDismissible: false,
      );
    }
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
    _genData();
  }

  void _genData() {
    if (_curnentScore != 0 && _curnentScore % 10 == 0) _level++;
    _answer = rng.nextBool();
    switch (rng.nextInt(4)) {
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
    int x = rng.nextInt(10 * _level) + 1;
    int y = rng.nextInt(10 * _level) + 1;
    int z = x + y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 * _level) + 1)
          : (z -= rng.nextInt(5 * _level) + 1);
    }
    _curnentCalculation = '$x + $y = $z';
  }

  void subtraction() {
    int x = rng.nextInt(10 * _level) + 1;
    int y = rng.nextInt(10 * _level) + 1;
    int z = x - y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 * _level) + 1)
          : (z -= rng.nextInt(5 * _level) + 1);
    }
    _curnentCalculation = '$x - $y = $z';
  }

  void multiplication() {
    int x = rng.nextInt(10 * _level) + 1;
    int y = rng.nextInt(10 * _level) + 1;
    int z = x * y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 * _level) + 1)
          : (z -= rng.nextInt(5 * _level) + 1);
    }
    _curnentCalculation = '$x x $y = $z';
  }

  void division() {
    int x = rng.nextInt(10 * _level) + 1;
    int y = rng.nextInt(10 * _level) + 1;
    int z = x * y;
    if (!_answer) {
      rng.nextBool()
          ? (z += rng.nextInt(5 * _level) + 1)
          : (z -= rng.nextInt(5 * _level) + 1);
    }
    _curnentCalculation = '$z / $y = $x';
  }

  @override
  Future<void> timeOut() {
    clearAll();
    Get.defaultDialog(
      title: 'Time Out!!!',
      middleText: '',
      confirm: TextButton(
        onPressed: () {
          Get.back();
          _genData();
        },
        child: Text('Chơi lại'),
      ),
      barrierDismissible: false,
    );
    // Get.dialog(
    //   SizedBox(
    //     height: 200.h,
    //     width: 300.h,
    //     child: Card(
    //         child: Column(
    //       children: [
    //         Text('Time Out!!!'),
    //         TextButton(
    //             onPressed: () {
    //               _genData();
    //             },
    //             child: Text('Chơi lại'))
    //       ],
    //     )),
    //   ),
    //   barrierDismissible: false,
    // );
  }

  int _level = 1;
  @override
  // TODO: implement level
  int get level => _level;
}
