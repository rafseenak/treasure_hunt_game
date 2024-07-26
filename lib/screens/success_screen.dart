import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/home_screen.dart';

class SuccessScreen extends StatefulWidget {
  final List playingToys;
  final List playingStudents;
  final Map playerDetails;
  final String level;
  const SuccessScreen({
    super.key,
    required this.playingToys,
    required this.playerDetails,
    required this.playingStudents,
    required this.level,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final AudioPlayer player = AudioPlayer();
  bool hasPlayedAudio = false;

  @override
  void initState() {
    super.initState();
    _playThirdAudio();
  }

  void _playThirdAudio() async {
    if (!hasPlayedAudio) {
      await player.play(AssetSource('audio/malayalam/ml-win.mp3'));
      setState(() {
        hasPlayedAudio = true;
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
              child: Image(
                image: AssetImage('assets/images/trophy.png'),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'അഭിനന്ദനങ്ങൾ',
              style: TextStyle(
                color: Color.fromARGB(255, 64, 153, 219),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Flexo',
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fixedSize: Size((screenWidth - 80), 60),
                  backgroundColor: const Color.fromARGB(255, 52, 47, 72),
                  foregroundColor: const Color.fromARGB(255, 250, 250, 250),
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontFamily: AutofillHints.addressCity,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const HomeScreen();
                      },
                    ),
                  );
                },
                child: const Text('Go to Home'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
