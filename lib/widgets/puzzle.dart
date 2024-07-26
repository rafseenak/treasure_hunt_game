import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/components/button_coponents.dart';
import 'package:treasure_hunt_game/controllers/speech_controller.dart';
import 'package:treasure_hunt_game/screens/track_screen.dart';

class Puzzle extends StatefulWidget {
  final Map playerDetails;
  final Map toyToFind;
  final List playingToys;
  final List playingStudents;
  final String level;
  const Puzzle({
    super.key,
    required this.playerDetails,
    required this.toyToFind,
    required this.playingToys,
    required this.playingStudents,
    required this.level,
  });
  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  TextToSpeechController textToSpeechController = TextToSpeechController();
  String result = '';
  void changeText(String num) {
    setState(() {
      if (num == '￩' && result.length - 1 > -1) {
        result = result.substring(0, result.length - 1);
      } else if (num != '￩' && result.length <= 2) {
        result = '$result$num';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/toy1.png'),
          height: 160,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NumberDisplay(value: '4'),
            const NumberDisplay(value: '+'),
            const NumberDisplay(value: '6'),
            const NumberDisplay(value: '='),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                width: 70,
                height: 60,
                child: Center(
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Flexo',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    NumberButton(number: '1', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '2', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '3', onPressed: changeText),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    NumberButton(number: '4', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '5', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '6', onPressed: changeText),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    NumberButton(number: '7', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '8', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '9', onPressed: changeText),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    NumberButton(number: '0', onPressed: changeText),
                    const SizedBox(width: 10),
                    NumberButton(number: '￩', onPressed: changeText),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 80, right: 80),
          child: ElevatedButton(
            onPressed: () {
              if (result == '10') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx1) => TrackScreen(
                      level: widget.level,
                      playerDetails: widget.playerDetails,
                      playingToys: widget.playingToys,
                      toyToFind: widget.toyToFind,
                      playingStudents: widget.playingStudents,
                    ),
                  ),
                );
              } else {
                textToSpeechController.speak("Oops! Wrong Answer. Try Again.");
                setState(() {
                  result = '';
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Oops!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Flexo',
                          color: Colors.black,
                        ),
                      ),
                      content: const Text(
                        'Wrong Answer',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Flexo',
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Flexo',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth, 50),
              backgroundColor: const Color.fromARGB(255, 162, 217, 91),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Color.fromARGB(255, 249, 252, 241),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Flexo',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
