import 'package:flutter/material.dart';

class DetailsStudent extends StatefulWidget {
  final Map studentName;
  final Function onPressed;
  const DetailsStudent({
    super.key,
    required this.studentName,
    required this.onPressed,
  });

  @override
  State<DetailsStudent> createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 40.0,
        right: 40.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 117, 121, 123),
            width: 0.5,
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
              child: CircleAvatar(),
            ),
            Center(
              child: Text(
                widget.studentName['studentDetails']['firstName'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    widget.onPressed(widget.studentName);
                  },
                  icon: const Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
