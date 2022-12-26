import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/extensions/dateTimeExtensions.dart';
import 'package:wordle/services/highScoreService.dart';
import 'package:wordle/services/streakService.dart';

import '../constants/constants.dart';

class DailyWordService {
  DailyWordService(this.isConnect);
  static final _defaultWordFetchDate = DateTime.now().subtract(const Duration(days: 365));
  static const _lastWordFetchDateStringKey = "lastWordFetchDateString";
  static const _lastWordKey = "lastWord";

  late ConnectivityResult isConnect;

  ValueNotifier<String?> todaysWord = ValueNotifier(null);
  ValueNotifier<bool> dayHasChanged = ValueNotifier(false);

  final _sharedPreferences = Get.find<SharedPreferences>();
  final _highScoreService = Get.find<HighScoreService>();
  final _streakService = Get.find<StreakService>();
  final _dateFormat = DateFormat("yyyy-MM-dd");

  String? get _lastWordFetchDateString => _sharedPreferences.getString(_lastWordFetchDateStringKey);

  set _lastWordFetchDateString(newValue) {
    _sharedPreferences.setString(_lastWordFetchDateStringKey, newValue);
  }

  DateTime get _lastWordFetchDate {
    final lastWordFetchDateString = _lastWordFetchDateString;

    if(lastWordFetchDateString == null) {
      return _defaultWordFetchDate;
    }

    return _dateFormat.parse(lastWordFetchDateString);
  }

  set _lastWordFetchDate(newValue) => _lastWordFetchDateString = _dateFormat.format(newValue);

  String? get _lastWord => _sharedPreferences.getString(_lastWordKey);

  set _lastWord(newValue) => _sharedPreferences.setString(_lastWordKey, newValue);

  Future<void> fetchTodaysWord() async {
    final now = DateTime.now();
    if(_lastWordFetchDate.isSame(now)) {
      todaysWord.value = _lastWord;
    } else{
      if(isConnect==ConnectivityResult.none){
        openDialog();
      }
      else{
        var url = Uri.https('wordle.denizbora.net', '/NewDay/${_highScoreService.highScore.value}');
        var response = await http.get(url);

        if(now.difference(_lastWordFetchDate)>const Duration(days: 2)){
          _streakService.streak.value=0;
        }
        _lastWordFetchDate = now;
        _lastWord = response.body;
        todaysWord.value = response.body;
        dayHasChanged.value = true;
      }
    }
  }
  void openDialog() {
    Get.dialog(
      barrierDismissible:false,
        AlertDialog(
      backgroundColor: black,
      content: SizedBox(
        width: Get.width * 0.65,
        height: Get.height * 0.15,
        child:Center(child: Text("Lütfen internete bağlanınız.",style: GoogleFonts.inter(
          color: textColor,
        ),))
      )
    ));
  }
}
