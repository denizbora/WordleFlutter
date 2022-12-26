import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/constants/constants.dart';

import '../controllers/gameController.dart';

class Tries extends StatefulWidget {
  const Tries({Key? key, required this.tries}) : super(key: key);

  final int tries;

  @override
  State<Tries> createState() => _TriesState();
}

class _TriesState extends State<Tries> {
  final GameController _controller = Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller.tries,
        builder: (context, tries, child) {
          return ValueListenableBuilder(valueListenable: _controller.triesDecoration, builder: (context,decorations,child){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(2.5),
                  width: Get.height * 0.086,
                  height: Get.height * 0.086,
                  decoration: decorations[widget.tries]![0],
                  child: Center(
                    child: Text(
                      tries[widget.tries]![0],
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.5),
                  width: Get.height * 0.086,
                  height: Get.height * 0.086,
                  decoration: decorations[widget.tries]![1],
                  child: Center(
                    child: Text(
                      tries[widget.tries]![1],
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.5),
                  width: Get.height * 0.086,
                  height: Get.height * 0.086,
                  decoration: decorations[widget.tries]![2],
                  child: Center(
                    child: Text(
                      tries[widget.tries]![2],
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.5),
                  width: Get.height * 0.086,
                  height: Get.height * 0.086,
                  decoration: decorations[widget.tries]![3],
                  child: Center(
                    child: Text(
                      tries[widget.tries]![3],
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.5),
                  width: Get.height * 0.086,
                  height: Get.height * 0.086,
                  decoration: decorations[widget.tries]![4],
                  child: Center(
                    child: Text(
                      tries[widget.tries]![4],
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }
}
