import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/secret_code_screen.dart';

class SelectedPlayersListScreen extends StatelessWidget {
  final String secretCode;
  final List playingStudents;
  final List playingToys;
  final String level;
  const SelectedPlayersListScreen({
    super.key,
    required this.secretCode,
    required this.playingStudents,
    required this.playingToys,
    required this.level,
  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Selected Players',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 52, 47, 72),
              fontFamily: 'Flexo',
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: playingStudents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                bottom: 4.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 117, 121, 123),
                    width: 0.5,
                  ),
                  color: const Color.fromARGB(255, 234, 241, 246),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: screenWidth,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      playingStudents[index]['studentDetails']['firstName'],
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx1) => SecretCodeScreen2(
                              level: level,
                              secretCode: secretCode.toString(),
                              playerDetails: playingStudents[index],
                              playingToys: playingToys,
                              selectedPlayers: playingStudents,
                            ),
                          ),
                          (route) => route.isFirst,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: DottedBorder(
                          radius: const Radius.circular(15),
                          strokeWidth: 3,
                          color: const Color.fromARGB(255, 52, 47, 72),
                          dashPattern: const [2, 6],
                          strokeCap: StrokeCap.square,
                          borderType: BorderType.RRect,
                          child: Center(
                            child: Text(
                              'Continue with ${playingStudents[index]['studentDetails']['firstName']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
