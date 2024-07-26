import 'package:flutter/material.dart';
import 'package:treasure_hunt_game/screens/create_game_screen.dart';

class LevelScreen extends StatefulWidget {
  final List playingStudents;
  final String teacherId;
  const LevelScreen({
    super.key,
    required this.playingStudents,
    required this.teacherId,
  });

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  List images = [
    {
      'img': 'assets/images/level_images/theme1.png',
      'name': 'ROAD',
    },

    // 'assets/images/level_images/level2.png',
    // 'assets/images/level_images/level3.png',
    // 'assets/images/level_images/level4.png',
    // 'assets/images/level_images/level5.png'
  ];
  String level = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Select Theme',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 52, 47, 72),
              fontFamily: 'Flexo',
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisExtent: 150,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  level = (index + 1).toString();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx1) => CreateGameScreen(
                        playingStudents: widget.playingStudents,
                        teacherId: widget.teacherId,
                        level: level,
                      ),
                    ),
                  );
                });
              },
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Center(
                            child: Image(
                          image: AssetImage(images[index]['img']),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        images[index]['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
