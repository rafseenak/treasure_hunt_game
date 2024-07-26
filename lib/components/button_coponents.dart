import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final String number;
  final Function(String) onPressed;
  const NumberButton({Key? key, required this.number, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        fixedSize: const Size(60, 60),
        textStyle: const TextStyle(),
        elevation: 8,
      ),
      onPressed: () {
        onPressed(number);
      },
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            fontFamily: 'Flexo',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class NumberDisplay extends StatelessWidget {
  final String value;

  const NumberDisplay({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        width: 50,
        height: 60,
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: 'Flexo',
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
