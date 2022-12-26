import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/constants/constants.dart';
import 'package:wordle/widgets/gameOverWidget.dart';
import 'package:wordle/widgets/keyboard.dart';
import 'package:wordle/widgets/tries.dart';

import '../controllers/gameController.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GameController _controller = Get.put(GameController());

  @override
  void initState() {
    super.initState();
    _controller.getPreferances();
    if(!_controller.isEnabled.value){
      _controller.openDialog();
    }
    _controller.isEnabled.addListener(() {_controller.openDialog();});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(
              width: 7,
            ),
            Icon(
              Icons.local_fire_department,
              color: Color.fromRGBO(215, 218, 220, 1),
              size: 25,
            ),
            SizedBox(
              width: 3,
            ),
            ValueListenableBuilder(
              valueListenable: _controller.streak,
              builder: (context, value, child) {
                return Text(
                  value.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(215, 218, 220, 1), fontSize: 25),
                );
              },
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Color.fromRGBO(215, 218, 220, 1),
                size: 25,
              ),
              SizedBox(
                width: 3,
              ),
             ValueListenableBuilder(
                valueListenable: _controller.highScore,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: TextStyle(
                        color: Color.fromRGBO(215, 218, 220, 1), fontSize: 25),
                  );
                },
              ),
              SizedBox(
                width: 7,
              ),
            ],
          ),
        ],
        backgroundColor: black,
        shadowColor: darkGrey,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: darkGrey,
          ),
        ),
        title: Center(
            child: Text(
          "WordleTR Mobile",
          style: TextStyle(fontFamily: "Karnak", color: textColor),
        )),
      ),
      body: Container(
        width: Get.width,
        height: Get.height - kToolbarHeight,
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.5625,
              child: Column(
                children: [
                  Tries(tries: 0),
                  Tries(tries: 1),
                  Tries(tries: 2),
                  Tries(tries: 3),
                  Tries(tries: 4),
                  Tries(tries: 5),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height * 0.277,
                child: Keyboard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
