import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:treasure_hunt_game/screens/level_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final player = AudioPlayer();

  void requestMicrophonePermission() async {
    await Permission.microphone.request();
  }

  @override
  void initState() {
    super.initState();
    requestMicrophonePermission();
  }

  @override
  Widget build(BuildContext context) {
    String startText = 'ആരംഭിക്കുക';
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 157, 222, 249),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 56, 50, 78),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Asraya Special School'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 56, 50, 78),
                  fontSize: 22,
                  fontFamily: 'Flexo',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
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
                        builder: (context) => const LevelScreen(
                          playingStudents: [],
                          teacherId: 'School1',
                        ),
                      ),
                    );
                  },
                  child: Text(startText),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
