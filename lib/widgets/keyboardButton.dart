import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/constants/constants.dart';

import '../controllers/gameController.dart';

class KeyboardButton extends StatelessWidget {
  KeyboardButton({Key? key, required this.icon}) : super(key: key);

  final GameController _controller = Get.put(GameController());

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        HapticFeedback.mediumImpact();
        if(icon == Icons.backspace_outlined){
          _controller.removeLetter();
        }
        else{
          _controller.addItem();
        }
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        width: Get.width / 13 + 20,
        height: Get.width / 8,
        decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Center(child: Icon(icon,color: textColor,),)
      ),
    );
  }
}
