import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/controllers/gameController.dart';

import '../constants/constants.dart';

class KeyboardButton extends StatelessWidget {
  KeyboardButton({Key? key, required this.character, required this.child, required this.width}) : super(key: key);

  final String character;
  final double width;
  final Widget child;

  final GameController _controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller.letters,
        builder: (context, value, childs) {
          return InkWell(
            onTap: (){
              HapticFeedback.mediumImpact();
              _controller.keyboardButtonPressed(character);
            },
            child: Container(
              margin: const EdgeInsets.all(3),
              width: width,
              height: Get.width / 8,
              decoration: BoxDecoration(
                  color: value[character],
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: child),
            ),
          );
        });
  }
}
