import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/screens/splashPage.dart';
import 'package:wordle/services/dailyWordService.dart';
import 'package:wordle/services/highScoreService.dart';
import 'package:wordle/services/streakService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await putDependencies();

  runApp(const MyApp());
}

Future<void> putDependencies() async {
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  ConnectivityResult isConnect = await checkConnectivity();

  Get.put(HighScoreService());
  Get.put(StreakService());
  Get.put(DailyWordService(isConnect));

}
Future<ConnectivityResult> checkConnectivity() async{
  final Connectivity connectivity = Connectivity();
  return await connectivity.checkConnectivity();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'WordleTR Mobile',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}