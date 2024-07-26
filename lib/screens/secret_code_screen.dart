import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/puzzle_screen.dart';

class SecretCodeScreen2 extends StatefulWidget {
  final List playingToys;
  final String secretCode;
  final Map playerDetails;
  final List selectedPlayers;
  final String level;
  const SecretCodeScreen2({
    super.key,
    required this.secretCode,
    required this.playerDetails,
    required this.playingToys,
    required this.selectedPlayers,
    required this.level,
  });

  @override
  State<SecretCodeScreen2> createState() => _SecretCodeScreen2State();
}

class _SecretCodeScreen2State extends State<SecretCodeScreen2> {
  String selectedSecretCode = '';
  List<String> secretCodes = [];

  @override
  void initState() {
    super.initState();
    _generateSecretCodes();
  }

  void _generateSecretCodes() {
    Random random = Random();
    int secretCode1;
    int secretCode2;
    do {
      secretCode1 = random.nextInt(9) + 1;
    } while (secretCode1 == int.parse(widget.secretCode));

    do {
      secretCode2 = random.nextInt(9) + 1;
    } while (secretCode2 == secretCode1 ||
        secretCode2 == int.parse(widget.secretCode));

    secretCodes = [
      widget.secretCode,
      secretCode1.toString(),
      secretCode2.toString(),
    ];
    secretCodes.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map toyToFind = widget.playingToys[0];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '${widget.playerDetails['studentDetails']['firstName']}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 52, 47, 72),
              fontFamily: 'Flexo',
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'നിങ്ങളുടെ രഹസ്യ നമ്പർ തിരഞ്ഞെടുക്കുക',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSecretCodeDisplay(secretCodes[0]),
              const SizedBox(width: 20),
              buildSecretCodeDisplay(secretCodes[1]),
              const SizedBox(width: 20),
              buildSecretCodeDisplay(secretCodes[2]),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (selectedSecretCode == widget.secretCode) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx1) => PuzzleScreen(
                      level: widget.level,
                      playerDetails: widget.playerDetails,
                      toyToFind: toyToFind,
                      playingToys: widget.playingToys,
                      playingStudents: widget.selectedPlayers,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'അയ്യോ!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Flexo',
                          color: Colors.black,
                        ),
                      ),
                      content: const Text(
                        'നിങ്ങൾ തിരഞ്ഞെടുത്ത രഹസ്യ നമ്പർ തെറ്റാണ്. ശരിയായ നമ്പർ തിരഞ്ഞെടുക്കൂ...',
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
            child: const Text(
              'തുടരുക',
              style: TextStyle(
                color: Color.fromARGB(255, 249, 252, 241),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Flexo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSecretCodeDisplay(String code) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSecretCode = code;
        });
      },
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
          borderRadius: BorderRadius.circular(10),
          color: selectedSecretCode == code
              ? Colors.red
              : const Color.fromARGB(255, 234, 241, 246),
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            code,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 56,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
