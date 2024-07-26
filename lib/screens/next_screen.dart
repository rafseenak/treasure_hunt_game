import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/components/button_coponents.dart';
import 'package:treasure_hunt_game/screens/selected_players_list_screen.dart';

class Next extends StatefulWidget {
  final List playingToys;
  final List playingStudents;
  final Map playerDetails;
  final String secretCode;
  final String level;
  const Next({
    super.key,
    required this.playingToys,
    required this.playerDetails,
    required this.playingStudents,
    required this.secretCode,
    required this.level,
  });

  @override
  State<Next> createState() => _NextState();
}

class _NextState extends State<Next> {
  final AudioPlayer _player = AudioPlayer();
  bool _isSecondAudioPlayed = false;
  bool _isThirdAudioPlayed = false;
  bool hasPlayedAudio = false;
  @override
  void initState() {
    super.initState();
    _playFirstAudio();
  }

  void _playFirstAudio() async {
    if (!hasPlayedAudio) {
      await _player.play(AssetSource('audio/malayalam/ml-win.mp3'));
      setState(() {
        hasPlayedAudio = true;
      });
      _player.onPlayerComplete.listen((event) {
        if (!_isSecondAudioPlayed) {
          _playSecondAudio();
        }
      });
    }
  }

  void _playSecondAudio() async {
    _isSecondAudioPlayed = true;
    await _player.play(AssetSource('audio/malayalam/ml-code2.mp3'));
    _player.onPlayerComplete.listen((event) {
      if (!_isThirdAudioPlayed) {
        _playThirdAudio();
      }
    });
  }

  void _playThirdAudio() async {
    _isThirdAudioPlayed = true;
    await _player.play(AssetSource('audio/malayalam/ml-codeshare.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '${widget.playerDetails['studentDetails']['firstName']} Playing',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 52, 47, 72),
              fontFamily: 'Flexo',
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 180,
              child: Image(
                image: AssetImage('assets/images/trophy.png'),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'CONGRATULATIONS',
              style: TextStyle(
                color: Color.fromARGB(255, 64, 153, 219),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Flexo',
              ),
            ),
            const Text(
              'New Secret Code Is',
              style: TextStyle(
                color: Color.fromARGB(255, 64, 153, 219),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Flexo',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberDisplay(value: widget.secretCode),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
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
                        return SelectedPlayersListScreen(
                          level: widget.level,
                          secretCode: widget.secretCode,
                          playingStudents: widget.playingStudents,
                          playingToys: widget.playingToys,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Find Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
