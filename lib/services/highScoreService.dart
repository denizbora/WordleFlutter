import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScoreService {
  static const _highScoreKey = "highScore";

  final _sharedPreferences = Get.find<SharedPreferences>();

  late ValueNotifier<int> highScore;

  HighScoreService() {
    highScore = ValueNotifier(_sharedPreferences.getInt(_highScoreKey) ?? 0);

    highScore.addListener(() {
      _sharedPreferences.setInt(_highScoreKey, highScore.value);
    });
  }
}
