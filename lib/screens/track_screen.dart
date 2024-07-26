import 'dart:async';
import 'dart:io';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/controllers/bluetooth_controller.dart';
import 'package:treasure_hunt_game/controllers/qr_controller.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TrackScreen extends StatefulWidget {
  final Map playerDetails;
  final Map toyToFind;
  final List playingToys;
  final String level;
  final List playingStudents;
  const TrackScreen({
    super.key,
    required this.playerDetails,
    required this.toyToFind,
    required this.playingToys,
    required this.playingStudents,
    required this.level,
  });

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final player = AudioPlayer();
  final BluetoothController _bluetoothController = BluetoothController();
  int rssi = -80;
  String toyToFindId = '';
  late Timer _timer;
  BluetoothAdapterState bluetoothState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _bluetoothStateSubscription;

  @override
  void initState() {
    super.initState();
    _checkBluetoothSupport();
    _bluetoothController.requestBluetoothPermissions();
    player.play(AssetSource('audio/malayalam/ml-far.mp3'));
    toyToFindId = widget.toyToFind['qr_data'];
    _startTimer();
  }

  Future<void> _checkBluetoothSupport() async {
    bool isSupported = await FlutterBluePlus.isSupported;
    if (!isSupported) {
      print("Bluetooth not supported by this device");
      return;
    }

    _bluetoothStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      setState(() {
        bluetoothState = state;
      });
    });

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  scanBluetooth() async {
    if (bluetoothState != BluetoothAdapterState.on) return;

    if (!_bluetoothController.isScanning()) {
      try {
        _bluetoothController.startScan();
        final devices = _bluetoothController.getScanResults();

        if (devices != null) {
          for (var i = 0; i < devices.length; i++) {
            var remoteIdString = devices[i].device.remoteId.toString();
            if (remoteIdString == toyToFindId) {
              setState(
                () {
                  rssi = devices[i].rssi;
                  _toggleVisibility();
                },
              );
            }
          }
        } else {
          print('No Bluetooth device found during scan');
        }
      } catch (e) {
        print('Start Scan Error: $e');
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      myFunction();
    });
  }

  void myFunction() {
    if (bluetoothState == BluetoothAdapterState.on) {
      scanBluetooth();
      startTracking();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _bluetoothController.stopScan();
    player.dispose();
    _bluetoothStateSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  double imageSize = 200.0;
  String text = 'നിങ്ങൾ ഇപ്പോൾ വളരെ ദൂരെയാണ്!';
  bool isVerifyVisible = false;
  Color rippleColor = const Color.fromARGB(255, 214, 214, 214);
  Color backgroundColor = const Color.fromARGB(255, 50, 56, 78);

  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void startTracking() {
    Color previousBackgroundColor = backgroundColor;
    setState(() {
      if (rssi >= -65) {
        imageSize = 350.0;
        isVerifyVisible = true;
        rippleColor = const Color.fromARGB(255, 214, 214, 214);
        backgroundColor = const Color.fromARGB(255, 122, 182, 44);
        text = 'നിങ്ങൾ അടുത്ത് എത്തിയിരിക്കുന്നു!';
      } else {
        imageSize = 200.0;
        isVerifyVisible = false;
        rippleColor = const Color.fromARGB(255, 214, 214, 214);
        backgroundColor = const Color.fromARGB(255, 50, 56, 78);
        text = 'നിങ്ങൾ ഇപ്പോൾ വളരെ ദൂരെയാണ്!';
      }
    });
    if (backgroundColor != previousBackgroundColor) {
      if (rssi >= -65) {
        player.play(AssetSource('audio/malayalam/ml-close.mp3'));
      } else {
        player.play(AssetSource('audio/malayalam/ml-far.mp3'));
      }
    }
  }

  void verify() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return QRViewExample(
            level: widget.level,
            toyToFind: widget.toyToFind,
            playingToys: widget.playingToys,
            playerDetails: widget.playerDetails,
            playingStudents: widget.playingStudents,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          //dummy rssi start
          SizedBox(
            height: 110,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '$rssi',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //dummy rssi end
          const Image(
            height: 150,
            image: AssetImage('assets/images/findme.png'),
          ),
          if (bluetoothState != BluetoothAdapterState.on)
            SizedBox(
              height: screenHeight - 500,
              child: const Center(
                child: Text(
                  'Please turn on Bluetooth',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: (screenHeight - 500),
              child: RippleAnimation(
                repeat: true,
                color: rippleColor,
                minRadius: 360,
                ripplesCount: 1,
                size: Size(screenWidth, (screenHeight - 500)),
                child: Center(
                  child: SizedBox(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: imageSize,
                      height: imageSize,
                      curve: Curves.easeInOut,
                      child: Image(
                        image: AssetImage(widget.toyToFind['image']),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 240,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      text,
                      key: Key(text),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: isVerifyVisible,
                  child: SizedBox(
                    height: 120,
                    child: InkWell(
                      onTap: verify,
                      child: const Image(
                        image: AssetImage('assets/images/scan.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
