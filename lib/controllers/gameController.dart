import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../widgets/gameOverWidget.dart';

class GameController extends GetxController {
  ValueNotifier<Map> letters = ValueNotifier<Map>({
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
  ValueNotifier<Map> tries = ValueNotifier<Map>({
    "first": "     ",
    "second": "     ",
    "third": "     ",
    "fourth": "     ",
    "fifth": "     ",
    "sixth": "     ",
  });
  ValueNotifier<Map> triesDecoration = ValueNotifier<Map>({
    "first": [notTry, notTry, notTry, notTry, notTry],
    "second": [notTry, notTry, notTry, notTry, notTry],
    "third": [notTry, notTry, notTry, notTry, notTry],
    "fourth": [notTry, notTry, notTry, notTry, notTry],
    "fifth": [notTry, notTry, notTry, notTry, notTry],
    "sixth": [notTry, notTry, notTry, notTry, notTry],
  });
  ValueNotifier<int> point = ValueNotifier<int>(0);
  ValueNotifier<int> streak = ValueNotifier<int>(0);
  final Connectivity _connectivity = Connectivity();
  String todaysWord = "";
  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;
  bool isFourth = false;
  bool isFifth = false;
  bool isSixth = false;
  bool isEnabled = true;
  ValueNotifier<bool> pointAdded = ValueNotifier(false);
  String day = "";

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  void addLetter(String item) {
    if (isEnabled) {
      if (isFirst == false) {
        if (tries.value["first"].contains(' ')) {
          int a = tries.value["first"].indexOf(' ');
          tries.value["first"] = replaceCharAt(tries.value["first"], a, item);
        }
      } else if (isSecond == false) {
        if (tries.value["second"].contains(' ')) {
          int a = tries.value["second"].indexOf(' ');
          tries.value["second"] = replaceCharAt(tries.value["second"], a, item);
        }
      } else if (isThird == false) {
        if (tries.value["third"].contains(' ')) {
          int a = tries.value["third"].indexOf(' ');
          tries.value["third"] = replaceCharAt(tries.value["third"], a, item);
        }
      } else if (isFourth == false) {
        if (tries.value["fourth"].contains(' ')) {
          int a = tries.value["fourth"].indexOf(' ');
          tries.value["fourth"] = replaceCharAt(tries.value["fourth"], a, item);
        }
      } else if (isFifth == false) {
        if (tries.value["fifth"].contains(' ')) {
          int a = tries.value["fifth"].indexOf(' ');
          tries.value["fifth"] = replaceCharAt(tries.value["fifth"], a, item);
        }
      } else if (isSixth == false) {
        if (tries.value["sixth"].contains(' ')) {
          int a = tries.value["sixth"].indexOf(' ');
          tries.value["sixth"] = replaceCharAt(tries.value["sixth"], a, item);
        }
      }
    }

    tries.notifyListeners();
  }

  void removeLetter() {
    if (isFirst == false && tries.value["first"] != '     ') {
      if (tries.value["first"].contains(' ')) {
        int a = tries.value["first"].indexOf(' ');
        tries.value["first"] = replaceCharAt(tries.value["first"], a - 1, ' ');
      } else {
        int a = tries.value["first"].length - 1;
        tries.value["first"] = replaceCharAt(tries.value["first"], a, ' ');
      }
    } else if (isSecond == false && tries.value["second"] != '     ') {
      if (tries.value["second"].contains(' ')) {
        int a = tries.value["second"].indexOf(' ');
        tries.value["second"] =
            replaceCharAt(tries.value["second"], a - 1, ' ');
      } else {
        int a = tries.value["second"].length - 1;
        tries.value["second"] = replaceCharAt(tries.value["second"], a, ' ');
      }
    } else if (isThird == false && tries.value["third"] != '     ') {
      if (tries.value["third"].contains(' ')) {
        int a = tries.value["third"].indexOf(' ');
        tries.value["third"] = replaceCharAt(tries.value["third"], a - 1, ' ');
      } else {
        int a = tries.value["third"].length - 1;
        tries.value["third"] = replaceCharAt(tries.value["third"], a, ' ');
      }
    } else if (isFourth == false && tries.value["fourth"] != '     ') {
      if (tries.value["fourth"].contains(' ')) {
        int a = tries.value["fourth"].indexOf(' ');
        tries.value["fourth"] =
            replaceCharAt(tries.value["fourth"], a - 1, ' ');
      } else {
        int a = tries.value["fourth"].length - 1;
        tries.value["fourth"] = replaceCharAt(tries.value["fourth"], a, ' ');
      }
    } else if (isFifth == false && tries.value["fifth"] != '     ') {
      if (tries.value["fifth"].contains(' ')) {
        int a = tries.value["fifth"].indexOf(' ');
        tries.value["fifth"] = replaceCharAt(tries.value["fifth"], a - 1, ' ');
      } else {
        int a = tries.value["fifth"].length - 1;
        tries.value["fifth"] = replaceCharAt(tries.value["fifth"], a, ' ');
      }
    } else if (isSixth == false && tries.value["sixth"] != '     ') {
      if (tries.value["sixth"].contains(' ')) {
        int a = tries.value["sixth"].indexOf(' ');
        tries.value["sixth"] = replaceCharAt(tries.value["sixth"], a - 1, ' ');
      } else {
        int a = tries.value["sixth"].length - 1;
        tries.value["sixth"] = replaceCharAt(tries.value["sixth"], a, ' ');
      }
    }
    tries.notifyListeners();
  }

  bool isWord(String wrd) {
    for (String element in wordList.split(',')) {
      if (element == wrd) {
        return true;
      }
    }
    return false;
  }

  Future<void> getTodaysWord() async {
    final prefs = await SharedPreferences.getInstance();
    var url =
        Uri.https('wordle.denizbora.net', '/NewDay/' + point.value.toString());
    var response = await http.get(url);
    todaysWord = response.body;
    await prefs.setString('todaysWord', todaysWord);
    await prefs.setString(
        'day', DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  List<BoxDecoration> comp(String indexed) {
    List<BoxDecoration> list = List<BoxDecoration>.filled(5, falseTry);
    String tdW = todaysWord;
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
        isFirst = true;
        triesDecoration.value["first"] = comp(tries.value["first"]);
        if (tries.value["first"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value += 6;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
      case 2:
        isSecond = true;
        triesDecoration.value["second"] = comp(tries.value["second"]);
        if (tries.value["second"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value += 5;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
      case 3:
        isThird = true;
        triesDecoration.value["third"] = comp(tries.value["third"]);
        if (tries.value["third"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value += 4;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
      case 4:
        isFourth = true;
        triesDecoration.value["fourth"] = comp(tries.value["fourth"]);
        if (tries.value["fourth"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value += 3;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
      case 5:
        isFifth = true;
        triesDecoration.value["fifth"] = comp(tries.value["fourth"]);
        if (tries.value["fourth"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value += 2;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
      case 6:
        isSixth = true;
        triesDecoration.value["sixth"] = comp(tries.value["sixth"]);
        if (tries.value["sixth"] == todaysWord) {
          isEnabled = false;
          if (pointAdded.value == false) {
            pointAdded.value = true;
            pointAdded.notifyListeners();
            point.value++;
            streak.value++;
            prefs.setInt("point", point.value);
            prefs.setInt("streak", streak.value);
            prefs.setBool('pointAdded', pointAdded.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        } else {
          isEnabled = false;
          if (pointAdded.value == false) {
            streak.value = 0;
            prefs.setInt("streak", streak.value);
          }
          prefs.setBool('IsEnabled', false);
          openDialog();
        }
        break;
    };
    tries.notifyListeners();
    triesDecoration.notifyListeners();
    point.notifyListeners();
    streak.notifyListeners();
  }

  AddItem(String item) async {
    final prefs = await SharedPreferences.getInstance();

    if (isWord(item)) {
      if (tries.value["first"] == item) {
        prefs.setString('first', tries.value["first"]);
        prefs.setBool('isFirst', isFirst);
        compare(1);
      } else if (tries.value["second"] == item) {
        prefs.setString('second', tries.value["second"]);
        prefs.setBool('isSecond', isSecond);
        compare(2);
      } else if (tries.value["third"] == item) {
        prefs.setString('third', tries.value["third"]);
        prefs.setBool('isThird', isThird);
        compare(3);
      } else if (tries.value["fourth"] == item) {
        prefs.setString('fourth', tries.value["fourth"]);
        prefs.setBool('isFourth', isFourth);
        compare(4);
      } else if (tries.value["fifth"] == item) {
        prefs.setString('fifth', tries.value["fifth"]);
        prefs.setBool('isFifth', isFifth);
        compare(5);
      } else if (tries.value["sixth"] == item) {
        prefs.setString('sixth', tries.value["sixth"]);
        prefs.setBool('isSixth', isSixth);
        compare(6);
      }
    } else {
      if (tries.value["first"] == item) {
        tries.value["first"] = '     ';
      } else if (tries.value["second"] == item) {
        tries.value["second"] = '     ';
      } else if (tries.value["third"] == item) {
        tries.value["third"] = '     ';
      } else if (tries.value["fourth"] == item) {
        tries.value["fourth"] = '     ';
      } else if (tries.value["fifth"] == item) {
        tries.value["fifth"] = '     ';
      } else if (tries.value["sixth"] == item) {
        tries.value["sixth"] = '     ';
      }
      tries.notifyListeners();
    }
  }

  Future<void> getPreferances() async {
    final prefs = await SharedPreferences.getInstance();
    point.value = prefs.getInt('point') ?? 0;
    day = prefs.getString('day') ??
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 2)));
    if (DateTime.now().difference(DateTime.parse(day)).inDays > 1) {
      streak.value = 0;
      prefs.setInt("streak", 0);
    } else {
      streak.value = prefs.getInt('streak') ?? 0;
    }
    if (day != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      ConnectivityResult connectivityResult =
          await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        SystemNavigator.pop();
      } else {
        await prefs.remove('todaysWord');
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
        getTodaysWord();
      }
    } else {
      todaysWord = prefs.getString('todaysWord') ?? "";
      tries.value["first"] = prefs.getString('first') ?? "     ";
      tries.value["second"] = prefs.getString('second') ?? "     ";
      tries.value["third"] = prefs.getString('third') ?? "     ";
      tries.value["fourth"] = prefs.getString('fourth') ?? "     ";
      tries.value["fifth"] = prefs.getString('fifth') ?? "     ";
      tries.value["sixth"] = prefs.getString('sixth') ?? "     ";
      isEnabled = prefs.getBool('IsEnabled') ?? true;
      isFirst = prefs.getBool('isFirst') ?? false;
      isSecond = prefs.getBool('isSecond') ?? false;
      isThird = prefs.getBool('isThird') ?? false;
      isFourth = prefs.getBool('isFourth') ?? false;
      isFifth = prefs.getBool('isFifth') ?? false;
      isSixth = prefs.getBool('isSixth') ?? false;
      pointAdded.value = prefs.getBool('pointAdded') ?? false;
      pointAdded.notifyListeners();
      if (tries.value["first"] != "     ") {
        compare(1);
      }
      if (tries.value["second"] != "     ") {
        compare(2);
      }
      if (tries.value["third"] != "     ") {
        compare(3);
      }
      if (tries.value["fourth"] != "     ") {
        compare(4);
      }
      if (tries.value["fifth"] != "     ") {
        compare(5);
      }
      if (tries.value["sixth"] != "     ") {
        compare(6);
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
            ValueListenableBuilder(
                valueListenable: pointAdded,
                builder: (context, value, child) {
                  return Text(
                    value
                        ? "Tebrikler kazandınız."
                        : "Kaybettiniz, sözcük : " + todaysWord,
                    style: GoogleFonts.inter(
                      color: textColor,
                    ),
                  );
                }),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              width: Get.width * 0.65,
              height: 2,
              color: darkGrey,
            ),
            isFirst ? GameOverWidget(tries: "first") : Container(),
            isSecond ? GameOverWidget(tries: "second") : Container(),
            isThird ? GameOverWidget(tries: "third") : Container(),
            isFourth ? GameOverWidget(tries: "fourth") : Container(),
            isFifth ? GameOverWidget(tries: "fifth") : Container(),
            isSixth ? GameOverWidget(tries: "sixth") : Container(),
            TweenAnimationBuilder<Duration>(
                duration: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).difference(DateTime.now()),
                tween: Tween(begin:  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).difference(DateTime.now()), end: Duration.zero),
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = (value.inMinutes % 60).toString().padLeft(2,"0");
                  final seconds = (value.inSeconds % 60).toString().padLeft(2,"0");
                  final hours = value.inHours.toString().padLeft(2,"0");
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('Bir sonraki kelimeye kalan süre: $hours:$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: textColor,
                          ),));
                }),
            InkWell(
              onTap: () async {
                var text = "Wordle Türkçe";
                if (isSixth) {
                  text += " 6/6";
                } else if (isFifth) {
                  text += " 5/6\n\n";
                } else if (isFourth) {
                  text += " 4/6\n\n";
                } else if (isThird) {
                  text += " 3/6\n\n";
                } else if (isSecond) {
                  text += " 2/6\n\n";
                } else if (isFirst) {
                  text += " 1/6\n\n";
                }
                if (triesDecoration.value["first"][0] != notTry) {
                  List<dynamic> firsts = triesDecoration.value["first"];
                  for (int i = 0; i < firsts.length; i++) {
                    if (firsts[i] == trueTry) {
                      text += "🟩";
                    } else if (firsts[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }
                if (triesDecoration.value["second"][0] != notTry) {
                  List<dynamic> seconds = triesDecoration.value["second"];
                  for (int i = 0; i < seconds.length; i++) {
                    if (seconds[i] == trueTry) {
                      text += "🟩";
                    } else if (seconds[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }
                if (triesDecoration.value["third"][0] != notTry) {
                  List<dynamic> thirds = triesDecoration.value["third"];
                  for (int i = 0; i < thirds.length; i++) {
                    if (thirds[i] == trueTry) {
                      text += "🟩";
                    } else if (thirds[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }
                if (triesDecoration.value["fourth"][0] != notTry) {
                  List<dynamic> fourths = triesDecoration.value["fourth"];
                  for (int i = 0; i < fourths.length; i++) {
                    if (fourths[i] == trueTry) {
                      text += "🟩";
                    } else if (fourths[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }
                if (triesDecoration.value["fifth"][0] != notTry) {
                  List<dynamic> fifths = triesDecoration.value["fifth"];
                  for (int i = 0; i < fifths.length; i++) {
                    if (fifths[i] == trueTry) {
                      text += "🟩";
                    } else if (fifths[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }
                if (triesDecoration.value["sixth"][0] != notTry) {
                  List<dynamic> sixths = triesDecoration.value["sixth"];
                  for (int i = 0; i < sixths.length; i++) {
                    if (sixths[i] == trueTry) {
                      text += "🟩";
                    } else if (sixths[i] == maybeTry) {
                      text += "🟨";
                    } else {
                      text += "⬛";
                    }
                  }
                  text += "\n";
                }

                await FlutterShare.share(
                  title: text.split("\n")[0],
                  text: text,
                  linkUrl: 'https://github.com/denizbora/Wordle',
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
}
