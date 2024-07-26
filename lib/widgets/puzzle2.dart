import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/controllers/treasure_data.dart';
import 'package:treasure_hunt_game/screens/track_screen.dart';

class Puzzle2 extends StatefulWidget {
  final Map playerDetails;
  final Map toyToFind;
  final List playingToys;
  final List playingStudents;
  final String level;

  const Puzzle2({
    super.key,
    required this.playerDetails,
    required this.toyToFind,
    required this.playingToys,
    required this.playingStudents,
    required this.level,
  });

  @override
  State<Puzzle2> createState() => _Puzzle2State();
}

class _Puzzle2State extends State<Puzzle2> {
  TreasureData treasureData = TreasureData();
  final player = AudioPlayer();
  int success = 0;
  bool dragging = false;
  bool isCorrect = false;
  var random = Random();
  late List puzzle;
  late List shuffledPuzzle;
  @override
  void initState() {
    super.initState();
    puzzle = treasureData.puzzleOneImages[0];
    shuffledPuzzle = List.from(puzzle)..shuffle(random);
    player.onPlayerComplete.listen((event) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => TrackScreen(
            level: widget.level,
            playerDetails: widget.playerDetails,
            toyToFind: widget.toyToFind,
            playingToys: widget.playingToys,
            playingStudents: widget.playingStudents,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 103, 99, 116),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 5),
                  shrinkWrap: true,
                  itemCount: shuffledPuzzle.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 5,
                        right: 5,
                      ),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 206, 199, 232),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Draggable(
                          data: shuffledPuzzle[index]['name'],
                          onDragStarted: () {
                            setState(() {
                              shuffledPuzzle[index]['dragging'] = true;
                            });
                          },
                          onDragEnd: (details) {
                            setState(() {
                              shuffledPuzzle[index]['dragging'] = false;
                            });
                          },
                          feedback: Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                    shuffledPuzzle[index]['original']),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: Center(
                            child: !(shuffledPuzzle[index]['isCorrect'])
                                ? ((shuffledPuzzle[index]['dragging'])
                                    ? null
                                    : Image(
                                        image: AssetImage(
                                          shuffledPuzzle[index]['original'],
                                        ),
                                      ))
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 103, 99, 116),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 5),
                  shrinkWrap: true,
                  itemCount: puzzle.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 5,
                        right: 5,
                      ),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 206, 199, 232),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: DragTarget(
                          builder: (
                            BuildContext context,
                            List<String?> incoming,
                            List<dynamic> rejected,
                          ) {
                            return SizedBox(
                              child: (puzzle[index]['isCorrect'])
                                  ? Image(
                                      image:
                                          AssetImage(puzzle[index]['original']),
                                    )
                                  : Image(
                                      image:
                                          AssetImage(puzzle[index]['shadow']),
                                    ),
                            );
                          },
                          onAcceptWithDetails: (data) {
                            if (data.data.toString() == puzzle[index]['name']) {
                              setState(() {
                                puzzle[index]['isCorrect'] = true;
                                success = success + 1;
                                if (success == puzzle.length) {
                                  player.play(
                                    AssetSource('audio/malayalam/ml-win3.mp3'),
                                  );
                                }
                              });
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
