import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wordle/widgets/keyboardButton.dart';
import 'package:wordle/widgets/keyboardLetter.dart';

import '../controllers/gameController.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.277,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardLetter(letter:"E",),
              KeyboardLetter(letter: "R"),
              KeyboardLetter(letter: "T"),
              KeyboardLetter(letter: "Y"),
              KeyboardLetter(letter: "U"),
              KeyboardLetter(letter: "I"),
              KeyboardLetter(letter: "O"),
              KeyboardLetter(letter: "P"),
              KeyboardLetter(letter: "Ğ"),
              KeyboardLetter(letter: "Ü"),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardLetter(letter: "A"),
              KeyboardLetter(letter: "S"),
              KeyboardLetter(letter: "D"),
              KeyboardLetter(letter: "F"),
              KeyboardLetter(letter: "G"),
              KeyboardLetter(letter: "H"),
              KeyboardLetter(letter: "J"),
              KeyboardLetter(letter: "K"),
              KeyboardLetter(letter: "L"),
              KeyboardLetter(letter: "Ş"),
              KeyboardLetter(letter: "İ"),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardButton(icon: Icons.keyboard_return),
              KeyboardLetter(letter: "Z"),
              KeyboardLetter(letter: "C"),
              KeyboardLetter(letter: "V"),
              KeyboardLetter(letter: "B"),
              KeyboardLetter(letter: "N"),
              KeyboardLetter(letter: "M"),
              KeyboardLetter(letter: "Ö"),
              KeyboardLetter(letter: "Ç"),
              KeyboardButton(icon: Icons.backspace_outlined),
            ],
          )
        ],
      ),
    );
  }
}
