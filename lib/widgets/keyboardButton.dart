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
          if (_controller.isFirst == false && !_controller.tries.value["first"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["first"]);
          } else if (_controller.isSecond == false &&
              !_controller.tries.value["second"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["second"]);
          } else if (_controller.isThird == false && !_controller.tries.value["third"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["third"]);
          } else if (_controller.isFourth == false &&
              !_controller.tries.value["fourth"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["fourth"]);
          } else if (_controller.isFifth == false && !_controller.tries.value["fifth"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["fifth"]);
          } else if (_controller.isSixth == false && !_controller.tries.value["sixth"].contains(' ')) {
            _controller.AddItem(_controller.tries.value["sixth"]);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(3),
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
