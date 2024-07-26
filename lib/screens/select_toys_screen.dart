// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/controllers/treasure_data.dart';
import 'package:treasure_hunt_game/screens/selected_players_list_screen.dart';

class SelecttoysScreen extends StatefulWidget {
  final List playingStudents;
  final String level;
  const SelecttoysScreen({
    super.key,
    required this.playingStudents,
    required this.level,
  });

  @override
  State<SelecttoysScreen> createState() => _SelecttoysScreenState();
}

class _SelecttoysScreenState extends State<SelecttoysScreen> {
  TreasureData treasureData = TreasureData();

  late List playingToys;
  @override
  void initState() {
    super.initState();
    playingToys = [];
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Select Toys',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            height: screenHeight - 200,
            child: GridView.builder(
              itemCount: playingToys.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisExtent: 200,
                mainAxisSpacing: 30,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == playingToys.length) {
                  return GestureDetector(
                    onTap: () {
                      if (playingToys.length < widget.playingStudents.length) {
                        showBottomSheet(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Maximum Toys Selected",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Flexo',
                                  color: Colors.black,
                                ),
                              ),
                              content: Text(
                                'You can Only select ${widget.playingStudents.length} Toys',
                                style: const TextStyle(
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
                                      'Back',
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
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 241, 246),
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
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 50,
                              ),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 47, 72),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: Center(
                                child: Image(
                                  image:
                                      AssetImage(playingToys[index]['image']),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Text(
                                playingToys[index]['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  playingToys.remove(playingToys[index]);
                                });
                              },
                              child: Container(
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
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          weight: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
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
              onPressed: () async {
                if (playingToys.length != widget.playingStudents.length) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Select exactly ${widget.playingStudents.length} Toys",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Flexo',
                            color: Colors.black,
                          ),
                        ),
                        content: Text(
                          'You should select exactly ${widget.playingStudents.length} Toys',
                          style: const TextStyle(
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
                                'Back',
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
                } else {
                  Random random = Random();
                  // var secretCode = random.nextInt(90) + 10;
                  var secretCode = random.nextInt(9) + 1;

                  await secretCodeAlert(context, secretCode);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx1) => SelectedPlayersListScreen(
                        level: widget.level,
                        secretCode: secretCode.toString(),
                        playingStudents: widget.playingStudents,
                        playingToys: playingToys,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Continue'),
            ),
          )
        ],
      ),
    );
  }

  secretCodeAlert(context, secretCode) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Secret Code',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
          content: Text(
            secretCode.toString(),
            style: const TextStyle(
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

  showBottomSheet(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List allToys = treasureData.allToys[0];
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Color.fromARGB(255, 234, 241, 246),
          ),
          child: SizedBox(
            height: (screenHeight - 370),
            child: ListView.builder(
              itemCount: (allToys.length),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 117, 121, 123),
                        width: 2,
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: (screenWidth),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 234, 241, 246),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Image(
                            image: AssetImage(
                              allToys[index]['image'],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 50,
                          width: 3,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 234, 241, 246),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        (playingToys.contains(allToys[index]))
                            ? Container(
                                margin: const EdgeInsets.all(10),
                                height: 100,
                                width: 150,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 234, 241, 246),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: DottedBorder(
                                  radius: const Radius.circular(15),
                                  strokeWidth: 2,
                                  color: const Color.fromARGB(255, 52, 47, 72),
                                  dashPattern: const [2, 4],
                                  strokeCap: StrokeCap.square,
                                  borderType: BorderType.RRect,
                                  child: const Center(
                                    child: Text(
                                      'Added',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 52, 47, 72),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    playingToys.add(allToys[index]);
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 100,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 52, 47, 72),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                      Text(
                                        'Add',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //..................................................................................
            // child: GridView.builder(
            //   itemCount: allToys.length,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //   ),
            //   itemBuilder: (BuildContext context, int index) {
            //     return GestureDetector(
            //       onTap: () {

            //       },
            //       child: SizedBox(
            //         height: 190,
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: 150,
            //               child: Container(
            //                 margin: const EdgeInsets.all(8.0),
            //                 child: Center(
            //                   child: Image(
            //                     image: AssetImage(allToys[index]['image']),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 30,
            //               child: Text(allToys[index]['name']),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        );
      },
    );
  }
}
