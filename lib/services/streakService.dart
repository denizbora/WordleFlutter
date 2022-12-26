import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const _streakKey = "streak";

  final _sharedPreferences = Get.find<SharedPreferences>();

  late ValueNotifier<int> streak;

  StreakService() {
    streak = ValueNotifier(_sharedPreferences.getInt(_streakKey) ?? 0);

    streak.addListener(() {
      _sharedPreferences.setInt(_streakKey, streak.value);
    });
  }
}
