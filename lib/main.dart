import 'package:flutter/material.dart';
import 'package:music_player/Controllers/page_manager.dart';
import 'package:music_player/Screen/home_screen.dart';
import 'package:music_player/constant.dart';
import 'package:music_player/services/audio_service.dart';

import 'Screen/music_screen.dart';

void main() async {
  await setupInitService();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);
  PageManager get _pageManager => PageManager();
  Duration get duration => Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [kGreendarkbackcolor, kGreendarkMenuandbackcolor])),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              children: [
                HomeScreen(
                  controller,
                  _pageManager,
                ),
                WillPopScope(
                    child: MusicScreen(controller, _pageManager),
                    onWillPop: () async {
                      controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                      return false;
                    })
              ],
            ),
          ),
        ));
  }
}
