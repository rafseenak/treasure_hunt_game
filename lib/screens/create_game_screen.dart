// ignore_for_file: use_build_context_synchronously

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/components/details_of_student.dart';
import 'package:treasure_hunt_game/components/student_details.dart';
import 'package:treasure_hunt_game/controllers/treasure_data.dart';
import 'package:treasure_hunt_game/screens/select_toys_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateGameScreen extends StatefulWidget {
  final List playingStudents;
  final String teacherId;
  final String level;
  const CreateGameScreen({
    super.key,
    required this.playingStudents,
    required this.teacherId,
    required this.level,
  });
  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  TreasureData treasureData = TreasureData();
  late List selectedStudents;
  List playingToys = [];
  List<dynamic> students = [];
  Future<void> _fetchStudents(String school) async {
    final Uri url = Uri.parse('${treasureData.baseUrl}stdents?school=$school');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        students = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch students');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStudents(widget.teacherId);
    selectedStudents = widget.playingStudents;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 228, 235),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: (screenHeight - 100),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fixedSize: Size((screenWidth - 40), 30),
                        backgroundColor: const Color.fromARGB(255, 52, 47, 72),
                        foregroundColor:
                            const Color.fromARGB(255, 250, 250, 250),
                        textStyle: const TextStyle(
                          fontSize: 26,
                          fontFamily: AutofillHints.addressCity,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Select Players !'),
                    ),
                  ),
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          height: (selectedStudents.length >= 5) ? 340 : null,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: selectedStudents.length,
                              itemBuilder: (context, index) {
                                return DetailsStudent(
                                  studentName: selectedStudents[index],
                                  onPressed: (Map student) {
                                    setState(() {
                                      selectedStudents.remove(student);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      (selectedStudents.isNotEmpty)
                          ? const Padding(
                              padding: EdgeInsets.only(left: 40.0, right: 40.0),
                              child: Divider(
                                color: Color.fromARGB(255, 117, 121, 123),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4.0,
                          left: 40.0,
                          right: 40.0,
                        ),
                        child: DottedBorder(
                          radius: const Radius.circular(50),
                          strokeWidth: 1,
                          dashPattern: const [8, 4],
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          child: GestureDetector(
                            onTap: () {
                              if (selectedStudents.length >= 4) {
                                maximumPlayerReachAlert(context);
                              } else {
                                showBottomSheet(context);
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 234, 241, 246),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Icon(
                                      Icons.face_outlined,
                                      size: 35,
                                      color: Color.fromARGB(255, 117, 121, 123),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'Add Player',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 117, 121, 123),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        if (selectedStudents.length >= 4) {
                                          maximumPlayerReachAlert(context);
                                        } else {
                                          showBottomSheet(context);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        size: 35,
                                      ),
                                      color: const Color.fromARGB(
                                          255, 117, 121, 123),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(
              height: 60,
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
                  if (selectedStudents.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx1) => SelecttoysScreen(
                          level: widget.level,
                          playingStudents: selectedStudents,
                        ),
                      ),
                    );
                  } else {
                    selectPlayersAlert(context);
                  }
                },
                child: const Text('Start'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    (students.isEmpty)
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Color.fromARGB(255, 234, 241, 246),
                ),
                height: (screenHeight / 2),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        : showStickyFlexibleBottomSheet(
            bottomSheetBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            minHeight: 0,
            initHeight: 0.5,
            maxHeight: 0.6,
            headerHeight: 20,
            context: context,
            bottomSheetColor: const Color.fromARGB(255, 234, 241, 246),
            headerBuilder: (BuildContext context, double offset) {
              return Container();
            },
            bodyBuilder: (BuildContext context, double offset) {
              return SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return StudentDetails(
                    studentName: students[index],
                    onPressed: (Map student, String score) {
                      Map student1 = {
                        'score': score,
                        'studentDetails': student,
                      };
                      setState(
                        () {
                          selectedStudents = List<Map>.from(selectedStudents);
                          if (!selectedStudents.contains(student1)) {
                            selectedStudents.add(student1);
                          }
                        },
                      );
                      Navigator.pop(context);
                    },
                    playingStudents: selectedStudents,
                    allStudents: students,
                  );
                },
                childCount: students.length,
              );
            },
            anchors: [0, 0.5, 0.6],
          );
  }

  selectPlayersAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Players',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
          content: const Text(
            'Select Players',
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

  maximumPlayerReachAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Can't Add More",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
          content: const Text(
            'Maximum 4 Players Allowded.',
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
}
