import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eth_transactions/pages/landing_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETH TRANSFER',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Image.asset('./assets/images/ethereum.png'),
            splashIconSize: 200,
            duration: 2000,
        nextScreen: LandingScreenPage(), splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xFF0F1012))
    );
  }
}
