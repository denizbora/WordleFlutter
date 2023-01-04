import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import 'keyboardButton.dart';



class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.277,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardButton(character:"E", width: Get.width / 14 ,
              child: Text(
                "E",
                style: GoogleFonts.inter(
                    color: textColor, fontWeight: FontWeight.w600),
              )),
              KeyboardButton(character:"R", width: Get.width / 14 ,
                  child: Text(
                    "R",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"T", width: Get.width / 14 ,
                  child: Text(
                    "T",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Y", width: Get.width / 14 ,
                  child: Text(
                    "Y",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"U", width: Get.width / 14 ,
                  child: Text(
                    "U",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"I", width: Get.width / 14 ,
                  child: Text(
                    "I",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"O", width: Get.width / 14 ,
                  child: Text(
                    "O",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"P", width: Get.width / 14 ,
                  child: Text(
                    "P",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Ğ", width: Get.width / 14 ,
                  child: Text(
                    "Ğ",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Ü", width: Get.width / 14 ,
                  child: Text(
                    "Ü",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardButton(character:"A", width: Get.width / 14 ,
                  child: Text(
                    "A",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"S", width: Get.width / 14 ,
                  child: Text(
                    "S",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"D", width: Get.width / 14 ,
                  child: Text(
                    "D",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"F", width: Get.width / 14 ,
                  child: Text(
                    "F",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"G", width: Get.width / 14 ,
                  child: Text(
                    "G",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"H", width: Get.width / 14 ,
                  child: Text(
                    "H",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"J", width: Get.width / 14 ,
                  child: Text(
                    "J",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"K", width: Get.width / 14 ,
                  child: Text(
                    "K",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"L", width: Get.width / 14 ,
                  child: Text(
                    "L",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Ş", width: Get.width / 14 ,
                  child: Text(
                    "Ş",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"İ", width: Get.width / 14 ,
                  child: Text(
                    "İ",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              KeyboardButton(character: 'enter', width: Get.width / 13 + 20,
              child: Icon(Icons.keyboard_return,color: textColor,),),
              KeyboardButton(character:"Z", width: Get.width / 14 ,
                  child: Text(
                    "Z",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"C", width: Get.width / 14 ,
                  child: Text(
                    "C",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"V", width: Get.width / 14 ,
                  child: Text(
                    "V",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"B", width: Get.width / 14 ,
                  child: Text(
                    "B",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"N", width: Get.width / 14 ,
                  child: Text(
                    "N",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"M", width: Get.width / 14 ,
                  child: Text(
                    "M",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Ö", width: Get.width / 14 ,
                  child: Text(
                    "Ö",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character:"Ç", width: Get.width / 14 ,
                  child: Text(
                    "Ç",
                    style: GoogleFonts.inter(
                        color: textColor, fontWeight: FontWeight.w600),
                  )),
              KeyboardButton(character: 'del', width: Get.width / 13 + 20,
              child: Icon(Icons.backspace_outlined,color: textColor,),),
            ],
          )
        ],
      ),
    );
  }
}
