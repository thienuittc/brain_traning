import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

abstract class IQuestionViewModel with ChangeNotifier {
  Future<void> init();
  String get curnentCalculation;
  int get curnentScore;
  Future<void> checkAnswer(bool answer);
  setCountdownController(CountdownController controller);
  Future<void> timeOut();
  int get level;
}
