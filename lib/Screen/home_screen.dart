// ignore_for_file: prefer_final_fields

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_player/Controllers/page_manager.dart';

import '../constant.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen(this.controller, this._pageManager, {Key? key}) : super(key: key);
  Offset distance = const Offset(28, 28);
  final PageManager _pageManager;
  final PageController controller;
  bool isPressedPrevious = true;
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    double blur = isPressed ? 10.0 : 30.0;
    Color color1 = isPressed ? cShadow1 : cNoShadow1;
    Color color2 = isPressed ? cShadow2 : cNoShadow2;
    double blur2 = isPressedPrevious ? 10.0 : 30.0;
    Color color5 = isPressedPrevious ? cShadow1 : cNoShadow1;
    Color color6 = isPressedPrevious ? cShadow2 : cNoShadow2;
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(
              Icons.menu,
              color: Colors.white,
              size: 25,
            ),
            Text('Nasheed Today',
                style: TextStyle(color: Colors.white, fontSize: 27)),
            Icon(
              Icons.search,
              size: 25,
              color: Colors.transparent,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
            valueListenable: _pageManager.playListNotifier,
            builder: (context, List<MediaItem> value, _) {
              if (value.isEmpty) {
                return Container();
              } else {
                return Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        if (value[index].artUri.toString() == '-1') {
                          return InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              onTap: () {
                                controller.animateToPage(1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut);
                                _pageManager.playfromPlaylist(index);

                                _pageManager.play();
                              },
                              child: GridTile(
                                footer: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.all(12),
                                    child: Text(
                                      value[index].title,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )),
                                child: const ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: Image(
                                      image: AssetImage(
                                    'assest/images/default5.jpg',
                                  )),
                                ),
                              ));
                        } else {
                          return InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              onTap: () {
                                controller.animateToPage(1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut);
                                _pageManager.playfromPlaylist(index);

                                _pageManager.play();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: GridTile(
                                  footer: Container(
                                      alignment: Alignment.bottomCenter,
                                      margin: const EdgeInsets.all(12),
                                      child: Text(
                                        value[index].title,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      )),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: FadeInImage(
                                          placeholder: const AssetImage(
                                              'assest/images/default5.jpg'),
                                          image: NetworkImage(
                                            value[index].artUri.toString(),
                                          ))),
                                ),
                              ));
                        }
                      }),
                );
              }
            }),
        GestureDetector(
            onTap: () {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            },
            child: Container(
              height: 110,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1B2516),
                    Color(0xff1F2B1A),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _pageManager.detailMusicNotifier,
                    builder:
                        (BuildContext context, MediaItem value, Widget? child) {
                      if (value.artUri.toString() == '-1') {
                        return const CircleAvatar(
                            radius: 37,
                            backgroundImage:
                                AssetImage('assest/images/default5.jpg'),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                child: Image(
                                  image:
                                      AssetImage('assest/images/default5.jpg'),
                                  width: 90,
                                  height: 90,
                                  alignment: Alignment.center,
                                )));
                      } else {
                        return CircleAvatar(
                          radius: 37,
                          backgroundImage:
                              const AssetImage('assest/images/default5.jpg'),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                    'assest/images/default5.jpg'),
                                image: NetworkImage(value.artUri.toString()),
                                width: 90,
                                height: 90,
                                alignment: Alignment.centerRight,
                              )),
                        );
                      }
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _pageManager.detailMusicNotifier,
                    builder:
                        (BuildContext context, MediaItem value, Widget? child) {
                      return Text(
                        value.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      );
                    },
                  ),
                  CircleAvatar(
                      backgroundColor: kbuttonColor1,
                      radius: 30,
                      child: CircleAvatar(
                          backgroundColor: kbuttonColor2,
                          radius: 25,
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: kbuttonColor3,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: blur,
                                          offset: -distance,
                                          color: color1,
                                          inset: isPressed,
                                        ),
                                        BoxShadow(
                                          blurRadius: blur,
                                          offset: distance,
                                          color: color2,
                                          inset: isPressed,
                                        ),
                                      ]),
                                  child: ValueListenableBuilder<ButtonState>(
                                      valueListenable:
                                          _pageManager.bttonStateNotifier,
                                      builder: (context, ButtonState value, _) {
                                        switch (value) {
                                          case ButtonState.load:
                                            return const CircularProgressIndicator();
                                          case ButtonState.play:
                                            return IconButton(
                                              padding: EdgeInsets.zero,
                                              highlightColor: kbuttonColor1,
                                              color: kbuttonColor2,
                                              disabledColor: kbuttonColor3,
                                              onPressed: () {
                                                _pageManager.pause();
                                              },
                                              icon: const Icon(
                                                Icons.play_arrow,
                                                color: Color.fromARGB(
                                                    255, 207, 158, 8),
                                                size: 40,
                                              ),
                                            );
                                          case ButtonState.paused:
                                            return IconButton(
                                              padding: EdgeInsets.zero,
                                              highlightColor: kbuttonColor1,
                                              color: kbuttonColor2,
                                              disabledColor: kbuttonColor3,
                                              onPressed: () {
                                                _pageManager.play();
                                              },
                                              icon: const Icon(
                                                Icons.pause,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            );
                                        }
                                      }))))),
                  CircleAvatar(
                      backgroundColor: kbuttonColor1,
                      radius: 20,
                      child: CircleAvatar(
                          backgroundColor: kbuttonColor2,
                          radius: 15,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kbuttonColor3,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: blur2,
                                        offset: -distance,
                                        color: color5,
                                        inset: isPressedPrevious,
                                      ),
                                      BoxShadow(
                                        blurRadius: blur2,
                                        offset: distance,
                                        color: color6,
                                        inset: isPressedPrevious,
                                      ),
                                    ]),
                                child: ValueListenableBuilder(
                                    valueListenable: _pageManager.isLastOne,
                                    builder: (context, bool value, _) {
                                      return IconButton(
                                        padding: EdgeInsets.zero,
                                        highlightColor: kbuttonColor1,
                                        color: kbuttonColor2,
                                        disabledColor: kbuttonColor3,
                                        onPressed: _pageManager.onSkipPressed,
                                        icon: Icon(
                                          Icons.skip_next,
                                          color: value
                                              ? Colors.black
                                              : Colors.white,
                                          size: 30,
                                        ),
                                      );
                                    })),
                          ))),
                ],
              ),
            )),
      ],
    );
  }
}
//  Expanded(
//             child: ValueListenableBuilder(
//                 valueListenable: _pageManager.playList,
//                 builder: (context, List<InfoMusic> value, _) {
//                   return ListView.builder(
//                     itemCount: value.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         onTap: () {},
//                         tileColor: Colors.blueGrey[600],
//                         leading: Container(
//                             decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(50),
//                               bottomRight: Radius.circular(50),
//                             )),
//                             child: ClipRRect(
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(40)),
//                                 child: Image(
//                                   image: AssetImage(value[index].assestImage),
//                                 ))),
//                         title: Text(
//                           value[index].title,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         subtitle: Text(value[index].artist),
//                       );
//                     },
//                   );
//                 })),
// 
        // 
        // GestureDetector(
        //                 onTap: () {},
        //                 child: Card(
        //                   borderOnForeground: true,
        //                   color: kGreendarkbackcolor,
        //                   child: Column(children: [
        //                     ClipRRect(
        //                       borderRadius:
        //                           const BorderRadius.all(Radius.circular(50)),
        //                       child: Image.asset(value[index].assestImage,
        //                           width: 120, height: 120),
        //                     ),
        //                     Text(
        //                       value[index].title,
        //                       style: const TextStyle(
        //                           color: Colors.white, fontSize: 20),
        //                     ),
        //                   ]),
        //                 ));
        //