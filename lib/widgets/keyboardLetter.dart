import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/controllers/gameController.dart';

import '../constants/constants.dart';

class KeyboardLetter extends StatelessWidget {
  KeyboardLetter({Key? key, required this.letter}) : super(key: key);

  final String letter;

  final GameController _controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller.letters,
        builder: (context, value, child) {
          return InkWell(
            onTap: (){
              HapticFeedback.mediumImpact();
              _controller.addLetter(letter);
            },
            child: Container(
              margin: EdgeInsets.all(3),
              width: Get.width / 14,
              height: Get.width / 8,
              decoration: BoxDecoration(
                  color: value[letter],
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Text(
                letter,
                style: GoogleFonts.inter(
                    color: textColor, fontWeight: FontWeight.w600),
              )),
            ),
          );
        });
  }
}
