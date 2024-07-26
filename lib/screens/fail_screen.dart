import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/track_screen.dart';

class FailScreen extends StatefulWidget {
  final List playingToys;
  final List playingStudents;
  final Map playerDetails;
  final Map toyToFind;
  final String level;
  const FailScreen({
    super.key,
    required this.playingToys,
    required this.playerDetails,
    required this.playingStudents,
    required this.toyToFind,
    required this.level,
  });

  @override
  State<FailScreen> createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  final AudioPlayer player = AudioPlayer();
  bool hasPlayedAudio = false;

  @override
  void initState() {
    super.initState();
    _playThirdAudio();
  }

  void _playThirdAudio() async {
    if (!hasPlayedAudio) {
      await player.play(AssetSource('audio/english/en-lose.mp3'));
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
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight - 300.0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 38, 38),
      body: RippleAnimation(
        repeat: true,
        color: const Color.fromARGB(255, 201, 189, 189),
        minRadius: 180,
        ripplesCount: 2,
        size: Size(screenWidth, screenHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 100),
            const Image(
              height: 100,
              image: AssetImage('assets/images/failtext.png'),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fail.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: SizedBox(
                height: imageHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (imageHeight - 120),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/failback.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fixedSize: Size((screenWidth - 80), 60),
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color.fromARGB(255, 150, 27, 18),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontFamily: AutofillHints.addressCity,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return TrackScreen(
                                      level: widget.level,
                                      playerDetails: widget.playerDetails,
                                      toyToFind: widget.toyToFind,
                                      playingToys: widget.playingToys,
                                      playingStudents: widget.playingStudents,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('വീണ്ടും ശ്രമിക്കുക'),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
