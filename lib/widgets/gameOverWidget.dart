import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gameController.dart';

class GameOverWidget extends StatelessWidget {
  GameOverWidget({Key? key, required this.tries}) : super(key: key);

  final int tries;

  final GameController _controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(3),
          decoration: _controller.triesDecoration.value[tries]![0],
          width: 35,
          height: 35,
        ),
        Container(
          margin: EdgeInsets.all(3),
          decoration: _controller.triesDecoration.value[tries]![1],
          width: 35,
          height: 35,
        ),
        Container(
          margin: EdgeInsets.all(3),
          decoration: _controller.triesDecoration.value[tries]![2],
          width: 35,
          height: 35,
        ),
        Container(
          margin: EdgeInsets.all(3),
          decoration: _controller.triesDecoration.value[tries]![3],
          width: 35,
          height: 35,
        ),
        Container(
          margin: EdgeInsets.all(3),
          decoration: _controller.triesDecoration.value[tries]![4],
          width: 35,
          height: 35,
        )
      ],
    );
  }
}
