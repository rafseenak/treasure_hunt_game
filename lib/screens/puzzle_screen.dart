import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/widgets/puzzle1.dart';
import 'package:treasure_hunt_game/widgets/puzzle2.dart';
import 'package:treasure_hunt_game/widgets/puzzle3.dart';

class PuzzleScreen extends StatelessWidget {
  final Map playerDetails;
  final Map toyToFind;
  final List playingToys;
  final List playingStudents;
  final String level;
  const PuzzleScreen({
    super.key,
    required this.playerDetails,
    required this.toyToFind,
    required this.playingToys,
    required this.playingStudents,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    List puzzles = [
      Puzzle1(
        level: level,
        playerDetails: playerDetails,
        toyToFind: toyToFind,
        playingToys: playingToys,
        playingStudents: playingStudents,
      ),
      Puzzle2(
        level: level,
        playerDetails: playerDetails,
        toyToFind: toyToFind,
        playingToys: playingToys,
        playingStudents: playingStudents,
      ),
      Puzzle3(
        level: level,
        playerDetails: playerDetails,
        toyToFind: toyToFind,
        playingToys: playingToys,
        playingStudents: playingStudents,
      )
    ];
    int randomIndex = random.nextInt(puzzles.length);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            '${playerDetails['studentDetails']['firstName']}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 52, 47, 72),
              fontFamily: 'Flexo',
            ),
          ),
        ),
      ),
      body: puzzles[randomIndex],
    );
  }
}
