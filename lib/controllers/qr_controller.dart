// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:treasure_hunt_game/controllers/treasure_data.dart';
import 'package:treasure_hunt_game/screens/fail_screen.dart';
import 'package:treasure_hunt_game/screens/next_screen.dart';
import 'package:treasure_hunt_game/screens/success_screen.dart';
import 'package:http/http.dart' as http;

class QRViewExample extends StatefulWidget {
  final Map toyToFind;
  final List playingToys;
  final List playingStudents;
  final Map playerDetails;
  final String level;
  const QRViewExample({
    super.key,
    required this.toyToFind,
    required this.playingToys,
    required this.playerDetails,
    required this.playingStudents,
    required this.level,
  });
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> {
  TreasureData treasureData = TreasureData();
  late StreamSubscription<Barcode> _streamSubscription;
  bool scoreUpdated = false;
  Future<void> _updateScore(String student) async {
    final Uri url = Uri.parse(
        '${treasureData.baseUrl}update_treasrehunt_score?studentName=$student&score=10&level=${widget.level}');
    final response = await http.put(url);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to fetch students');
    }
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "VERIFY";
  late String secretCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Random random = Random();
    secretCode = (random.nextInt(9) + 1).toString();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    _streamSubscription = controller.scannedDataStream.listen((scanData) async {
      setState(() {
        qrText = scanData.code.toString();
      });
      if (widget.toyToFind['qr_data'] == qrText) {
        if (!scoreUpdated) {
          _updateScore(widget.playerDetails['studentDetails']['_id']);
          scoreUpdated = true;
        }

        widget.playingStudents.remove(widget.playerDetails);
        widget.playingToys.remove(widget.toyToFind);
        if (widget.playingToys.isEmpty || widget.playingStudents.isEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return SuccessScreen(
                  level: widget.level,
                  playingToys: widget.playingToys,
                  playerDetails: widget.playerDetails,
                  playingStudents: widget.playingStudents,
                );
              },
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return Next(
                  level: widget.level,
                  secretCode: secretCode.toString(),
                  playingStudents: widget.playingStudents,
                  playingToys: widget.playingToys,
                  playerDetails: widget.playerDetails,
                );
              },
            ),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) {
              return FailScreen(
                level: widget.level,
                playingToys: widget.playingToys,
                playerDetails: widget.playerDetails,
                playingStudents: widget.playingStudents,
                toyToFind: widget.toyToFind,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    controller?.dispose();
    super.dispose();
  }
}
