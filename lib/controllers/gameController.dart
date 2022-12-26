import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/constants/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wordle/services/dailyWordService.dart';
import 'package:wordle/services/highScoreService.dart';
import 'package:wordle/services/streakService.dart';

import '../widgets/gameOverWidget.dart';

class GameController extends GetxController {
  ValueNotifier<Map<String, Color>> letters =
      ValueNotifier<Map<String, Color>>({
    "E": lightGrey,
    "R": lightGrey,
    "T": lightGrey,
    "Y": lightGrey,
    "U": lightGrey,
    "I": lightGrey,
    "O": lightGrey,
    "P": lightGrey,
    "Ğ": lightGrey,
    "Ü": lightGrey,
    "A": lightGrey,
    "S": lightGrey,
    "D": lightGrey,
    "F": lightGrey,
    "G": lightGrey,
    "H": lightGrey,
    "J": lightGrey,
    "K": lightGrey,
    "L": lightGrey,
    "Ş": lightGrey,
    "İ": lightGrey,
    "Z": lightGrey,
    "C": lightGrey,
    "V": lightGrey,
    "B": lightGrey,
    "N": lightGrey,
    "M": lightGrey,
    "Ö": lightGrey,
    "Ç": lightGrey
  });
  ValueNotifier<Map<int, String>> tries = ValueNotifier<Map<int, String>>({
    0: "     ",
    1: "     ",
    2: "     ",
    3: "     ",
    4: "     ",
    5: "     ",
  });
  ValueNotifier<Map<int, List<BoxDecoration>>> triesDecoration =
      ValueNotifier<Map<int, List<BoxDecoration>>>({
    0: [notTry, notTry, notTry, notTry, notTry],
    1: [notTry, notTry, notTry, notTry, notTry],
    2: [notTry, notTry, notTry, notTry, notTry],
    3: [notTry, notTry, notTry, notTry, notTry],
    4: [notTry, notTry, notTry, notTry, notTry],
    5: [notTry, notTry, notTry, notTry, notTry],
  });
  Map<int, bool> triesColumn = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false
  };
  late ValueNotifier<int> highScore =
      ValueNotifier(_highScoreService.highScore.value);
  late ValueNotifier<int> streak = ValueNotifier(_streakService.streak.value);
  final _dailyWordService = Get.find<DailyWordService>();
  final _highScoreService = Get.find<HighScoreService>();
  final _streakService = Get.find<StreakService>();

  ValueNotifier<bool> isEnabled = ValueNotifier(true);
  bool pointAdded = false;
  String day = "";

  GameController() {
    _highScoreService.highScore.addListener(() {
      highScore.value = _highScoreService.highScore.value;
    });
    _streakService.streak.addListener(() {
      streak.value = _streakService.streak.value;
    });
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  void addLetter(String item) {
    if (isEnabled.value) {
      for (int i = 0; i < triesColumn.length; i++) {
        if (!triesColumn[i]!) {
          if (tries.value[i]!.contains(' ')) {
            int a = tries.value[i]!.indexOf(' ');
            tries.value[i] = replaceCharAt(tries.value[i]!, a, item);
          }
          break;
        }
      }
    }

    tries.notifyListeners();
  }

  void removeLetter() {
    if (isEnabled.value) {
      for (int i = 0; i < triesColumn.length; i++) {
        if (!triesColumn[i]!) {
          if (tries.value[i]!.contains(' ')) {
            int a = tries.value[i]!.indexOf(' ');
            tries.value[i] = replaceCharAt(tries.value[i]!, a - 1, ' ');
          }
          break;
        }
      }
      tries.notifyListeners();
    }
  }

  bool isWord(String wrd) {
    for (String element in wordList.split(',')) {
      if (element == wrd) {
        return true;
      }
    }
    return false;
  }

  List<BoxDecoration> comp(String indexed) {
    List<BoxDecoration> list = List<BoxDecoration>.filled(5, falseTry);
    String tdW = _dailyWordService.todaysWord.value ?? "";
    for (int i = 0; i < indexed.length; i++) {
      if (tdW[i] == indexed[i]) {
        list[i] = trueTry;
        letters.value[indexed[i]] = green;
        var c = "";
        var k = "";
        for (int j = 0; j < tdW.length; j++) {
          if (j != i) {
            c += tdW[j];
          } else {
            c += ' ';
          }
        }
        tdW = c;
        for (int j = 0; j < indexed.length; j++) {
          if (i != j) {
            k += indexed[j];
          } else {
            k += ' ';
          }
        }

        indexed = k;
      } else {
        list[i] = falseTry;

        if (letters.value[indexed[i]] != green &&
            letters.value[indexed[i]] != yellow) {
          letters.value[indexed[i]] = darkGrey;
        }
      }
    }
    for (int i = 0; i < indexed.length; i++) {
      if (indexed[i] != ' ') {
        if (tdW.contains(indexed[i])) {
          list[i] = maybeTry;
          if (letters.value[indexed[i]] != green) {
            letters.value[indexed[i]] = yellow;
          }
          var d = tdW.indexOf(indexed[i]);
          var c = "";
          for (int j = 0; j < tdW.length; j++) {
            if (j != d) {
              c += tdW[j];
            } else {
              c += ' ';
            }
          }

          tdW = c;
        } else {
          list[i] = falseTry;
          if (letters.value[indexed[i]] != green &&
              letters.value[indexed[i]] != yellow) {
            letters.value[indexed[i]] = darkGrey;
          }
        }
      }
    }
    letters.notifyListeners();
    return list;
  }

  Future<void> compare(int i) async {
    final prefs = await SharedPreferences.getInstance();

    switch (i) {
      case 1:
        compareStep(i, prefs);
        break;
      case 2:
        compareStep(i, prefs);
        break;
      case 3:
        compareStep(i, prefs);
        break;
      case 4:
        compareStep(i, prefs);
        break;
      case 5:
        compareStep(i, prefs);
        break;
      case 6:
        compareStep(i, prefs);
        triesDecoration.value[i] = comp(tries.value[i]!);
        if (tries.value["sixth"] != _dailyWordService.todaysWord.value) {
          if (pointAdded == false) {
            streak.value = 0;
            prefs.setInt("streak", streak.value);
          }
          isEnabled.value = false;
        }
        break;
    }

    triesDecoration.notifyListeners();
    tries.notifyListeners();
  }

  AddItem() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < triesColumn.length; i++) {
      if (!triesColumn[i]! && !tries.value[i]!.contains(' ')) {
        if (isWord(tries.value[i]!)) {
          for (int j = 0; j < tries.value.length; j++) {
            switch (i) {
              case 0:
                prefs.setString('first', tries.value[i]!);
                prefs.setBool('isFirst', triesColumn[i]!);
                break;
              case 1:
                prefs.setString('second', tries.value[i]!);
                prefs.setBool('isSecond', triesColumn[i]!);
                break;
              case 2:
                prefs.setString('third', tries.value[i]!);
                prefs.setBool('isThird', triesColumn[i]!);
                break;
              case 3:
                prefs.setString('fourth', tries.value[i]!);
                prefs.setBool('isFourth', triesColumn[i]!);
                break;
              case 4:
                prefs.setString('fift', tries.value[i]!);
                prefs.setBool('isFifth', triesColumn[i]!);
                break;
              case 5:
                prefs.setString('sixth', tries.value[i]!);
                prefs.setBool('isSixth', triesColumn[i]!);
                break;
            }
            compare(i + 1);
            break;
          }
        } else {
          tries.value[i] = "     ";
        }
        tries.notifyListeners();
      }
    }
  }

  Future<void> getPreferances() async {
    final prefs = await SharedPreferences.getInstance();

    if (_dailyWordService.dayHasChanged.value) {
      await prefs.remove('first');
      await prefs.remove('second');
      await prefs.remove('third');
      await prefs.remove('fourth');
      await prefs.remove('fifth');
      await prefs.remove('sixth');
      await prefs.remove('IsEnabled');
      await prefs.remove('isFirst');
      await prefs.remove('isSecond');
      await prefs.remove('isThird');
      await prefs.remove('isFourth');
      await prefs.remove('isFifth');
      await prefs.remove('isSixth');
      await prefs.remove('pointAdded');
    }
    else {
      tries.value[0] = prefs.getString('first') ?? "     ";
      tries.value[1] = prefs.getString('second') ?? "     ";
      tries.value[2] = prefs.getString('third') ?? "     ";
      tries.value[3] = prefs.getString('fourth') ?? "     ";
      tries.value[4] = prefs.getString('fifth') ?? "     ";
      tries.value[5] = prefs.getString('sixth') ?? "     ";
      triesColumn[0] = prefs.getBool('isFirst') ?? false;
      triesColumn[1] = prefs.getBool('isSecond') ?? false;
      triesColumn[2] = prefs.getBool('isThird') ?? false;
      triesColumn[3] = prefs.getBool('isFourth') ?? false;
      triesColumn[4] = prefs.getBool('isFifth') ?? false;
      triesColumn[5] = prefs.getBool('isSixth') ?? false;
      pointAdded = prefs.getBool('pointAdded') ?? false;
      for (int i = 0; i < tries.value.length; i++) {
        if (tries.value[i] != "     ") {
          compare(i + 1);
        }
      }
    }
  }

  void openDialog() {
    Get.dialog(AlertDialog(
      backgroundColor: black,
      content: Container(
        width: Get.width * 0.65,
        height: Get.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              pointAdded
                  ? "Tebrikler kazandınız."
                  : "Kaybettiniz, sözcük : " +
                      (_dailyWordService.todaysWord.value ?? ""),
              style: GoogleFonts.inter(
                color: textColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              width: Get.width * 0.65,
              height: 2,
              color: darkGrey,
            ),
            triesColumn[0]! ? GameOverWidget(tries: 0) : Container(),
            triesColumn[1]! ? GameOverWidget(tries: 1) : Container(),
            triesColumn[2]! ? GameOverWidget(tries: 2) : Container(),
            triesColumn[3]! ? GameOverWidget(tries: 3) : Container(),
            triesColumn[4]! ? GameOverWidget(tries: 4) : Container(),
            triesColumn[5]! ? GameOverWidget(tries: 5) : Container(),
            TweenAnimationBuilder<Duration>(
                duration: DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day + 1)
                    .difference(DateTime.now()),
                tween: Tween(
                    begin: DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day + 1)
                        .difference(DateTime.now()),
                    end: Duration.zero),
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes =
                      (value.inMinutes % 60).toString().padLeft(2, "0");
                  final seconds =
                      (value.inSeconds % 60).toString().padLeft(2, "0");
                  final hours = value.inHours.toString().padLeft(2, "0");
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Bir sonraki kelimeye kalan süre: $hours:$minutes:$seconds',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: textColor,
                        ),
                      ));
                }),
            InkWell(
              onTap: () async {
                var text = "Wordle Türkçe ";
                for (int i = 0; i < triesColumn.length; i++) {
                  if (triesColumn[i]!) {
                    text += "${i+1}/6\n";
                    break;
                  }
                }
                for (int i = 0; i < triesDecoration.value.length; i++) {
                  if (triesDecoration.value[i]![0] != notTry) {
                    for (int j = 0; j < triesDecoration.value[i]!.length; j++) {
                      if (triesDecoration.value[i]![j] == trueTry) {
                        text += "🟩";
                      } else if (triesDecoration.value[i]![j] == maybeTry) {
                        text += "🟨";
                      } else {
                        text += "⬛";
                      }
                    }
                    text += "\n";
                  }
                }
                await FlutterShare.share(
                  title: text.split("\n")[0],
                  text: text,
                  linkUrl: 'https://github.com/denizbora/WordleFlutter',
                );
              },
              child: Container(
                color: green,
                width: 199,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Paylaş",
                      style: TextStyle(color: textColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.share,
                      color: textColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void compareStep(int i, SharedPreferences prefs) {
    triesColumn[i - 1] = true;
    triesDecoration.value[i - 1] = comp(tries.value[i - 1]!);
    if (tries.value[i - 1] == _dailyWordService.todaysWord.value) {
      if (pointAdded == false) {
        pointAdded = true;
        _highScoreService.highScore.value += 7 - i;
        _streakService.streak.value++;
        prefs.setBool('pointAdded', pointAdded);
      }
      isEnabled.value = false;
    }
  }
}
