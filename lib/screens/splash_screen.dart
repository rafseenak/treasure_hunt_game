import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoFirstpage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/splash.png'),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
              child: LinearProgressIndicator(
                color: Color.fromARGB(255, 52, 47, 72),
                backgroundColor: Color.fromARGB(255, 255, 254, 251),
                minHeight: 20,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoFirstpage() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => const HomeScreen()),
      (route) => false,
    );
  }
}
