import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/constants/constants.dart';
import 'package:wordle/screens/mainPage.dart';

import '../controllers/gameController.dart';
import '../widgets/gameOverWidget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GameController _controller = Get.put(GameController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Get.off(() => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: darkGrey,
      child: Center(child: Container(width: 250,height: 250,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/logo.png"))),)),
    );
  }

}
