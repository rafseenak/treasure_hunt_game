import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:treasure_hunt_game/controllers/treasure_data.dart';

class StudentDetails extends StatefulWidget {
  final Map studentName;
  final List allStudents;
  final List playingStudents;
  final Function onPressed;
  const StudentDetails({
    super.key,
    required this.studentName,
    required this.onPressed,
    required this.playingStudents,
    required this.allStudents,
  });

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Map<String, dynamic> scores = {};
  TreasureData treasureData = TreasureData();

  Future<void> _fetchStudentScore(String studentName) async {
    final Uri url = Uri.parse(
        '${treasureData.baseUrl}getStudentScore?studentName=$studentName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        if (json.decode(response.body) != null) {
          scores = json.decode(response.body);
        }
      });
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch Score details');
    }
  }

  bool isMapPresent(List list, Map mapToFind) {
    for (var item in list) {
      if (mapEquals(item['studentDetails'], mapToFind)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _fetchStudentScore(widget.studentName['_id']);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 20.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: (!isMapPresent(widget.playingStudents, widget.studentName))
            ? () {
                String score = '';
                (scores.isNotEmpty) ? score = scores['score'] : score = '0';
                widget.onPressed(widget.studentName, score);
              }
            : () {
                alreadySelectAlert(context);
              },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 117, 121, 123),
              width: 1.0,
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(50.0),
          ),
          width: screenWidth,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 209, 234, 231),
                ),
              ),
              Center(
                child: Text(
                  widget.studentName['firstName'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  child: IconButton(
                    color: Colors.black,
                    icon: (!isMapPresent(
                            widget.playingStudents, widget.studentName))
                        ? const Icon(Icons.person_add_alt_outlined)
                        : const Icon(
                            Icons.person_add_alt_outlined,
                            color: Colors.red,
                          ),
                    onPressed: (!isMapPresent(
                            widget.playingStudents, widget.studentName))
                        ? () {
                            String score = '';
                            (scores.isNotEmpty)
                                ? score = scores['score']
                                : score = '0';
                            widget.onPressed(widget.studentName, score);
                          }
                        : () {
                            alreadySelectAlert(context);
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alreadySelectAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Player Already Selected",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
          content: Text(
            '${widget.studentName['firstName']} is Already Selected.',
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
}
