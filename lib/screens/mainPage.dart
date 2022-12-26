import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/constants/constants.dart';
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
            const SizedBox(
              width: 7,
            ),
            const Icon(
              Icons.local_fire_department,
              color: Color.fromRGBO(215, 218, 220, 1),
              size: 25,
            ),
            const SizedBox(
              width: 3,
            ),
            ValueListenableBuilder(
              valueListenable: _controller.streak,
              builder: (context, value, child) {
                return Text(
                  value.toString(),
                  style: const TextStyle(
                      color: Color.fromRGBO(215, 218, 220, 1), fontSize: 25),
                );
              },
            )
          ],
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color.fromRGBO(215, 218, 220, 1),
                size: 25,
              ),
              const SizedBox(
                width: 3,
              ),
             ValueListenableBuilder(
                valueListenable: _controller.highScore,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(
                        color: Color.fromRGBO(215, 218, 220, 1), fontSize: 25),
                  );
                },
              ),
              const SizedBox(
                width: 7,
              ),
            ],
          ),
        ],
        backgroundColor: black,
        shadowColor: darkGrey,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: darkGrey,
          ),
        ),
        title: const Center(
            child: Text(
          "WordleTR Mobile",
          style: TextStyle(fontFamily: "Karnak", color: textColor),
        )),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height - kToolbarHeight,
        child: Stack(
          children: [
            SizedBox(
              height: Get.height * 0.5625,
              child: Column(
                children: const [
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
              child: SizedBox(
                height: Get.height * 0.277,
                child: const Keyboard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
