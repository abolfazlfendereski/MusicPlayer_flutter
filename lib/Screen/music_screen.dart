// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:music_player/Widget/speedoption.dart';
import 'package:music_player/Widget/timer.dart';

import 'package:music_player/constant.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../Controllers/page_manager.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen(this.controller, this.pageManager, {Key? key})
      : super(key: key);

  final PageController controller;
  final PageManager pageManager;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  late Size size;
  TimePicker? timepick = TimePicker.fivemin;
  // ignore: avoid_init_to_null
  Duration valuetime = Duration.zero;
  Timer? timer;
  bool isPressed = true;
  bool isPressedSkip = true;
  bool isPressedPrevious = true;
  bool _isVisible = false;
  late bool _VisitSpeed = false;
  bool clickhurt = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    if (valuetime != Duration.zero) {}
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    // ignore: dead_code
    Offset distance = const Offset(28, 28);
    // ignore: dead_code
    double blur = isPressed ? 10.0 : 30.0;
    Color color1 = isPressed ? cShadow1 : cNoShadow1;
    Color color2 = isPressed ? cShadow2 : cNoShadow2;
    double blur1 = isPressedSkip ? 10.0 : 30.0;
    Color color3 = isPressedSkip ? cShadow1 : cNoShadow1;
    Color color4 = isPressedSkip ? cShadow2 : cNoShadow2;
    double blur2 = isPressedPrevious ? 10.0 : 30.0;
    Color color5 = isPressedPrevious ? cShadow1 : cNoShadow1;
    Color color6 = isPressedPrevious ? cShadow2 : cNoShadow2;

    return Stack(
      children: [
        SizedBox(
            height: size.height,
            width: size.width,
            child: ValueListenableBuilder(
                valueListenable: widget.pageManager.detailMusicNotifier,
                builder: (context, MediaItem value, _) {
                  if (value.artUri.toString() == '-1') {
                    return const Image(
                      image: AssetImage('assest/images/default5.jpg'),
                      fit: BoxFit.cover,
                    );
                  } else {
                    return FadeInImage(
                      placeholder:
                          const AssetImage('assest/images/default5.jpg'),
                      image: NetworkImage(value.artUri.toString()),
                      fit: BoxFit.cover,
                    );
                  }
                })),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Text('Now Playing',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clickhurt = !clickhurt;
                      });
                      print(clickhurt);
                    },
                    icon: Icon(
                      clickhurt ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: clickhurt ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    Visibility(
                        visible: _isVisible,
                        child: Row(
                          children: [
                            TimerCountDown(widget.pageManager),
                            Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(70)),
                              color: const Color.fromARGB(255, 105, 104, 104),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(70)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _VisitSpeed = !_VisitSpeed;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.one_x_mobiledata_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable:
                                  widget.pageManager.volumeStateNotifier,
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                if (value == 0) {
                                  return Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(70)),
                                    color: const Color.fromARGB(
                                        255, 105, 104, 104),
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(70)),
                                      onTap: widget.pageManager.onVolumePressed,
                                      child: IconButton(
                                        onPressed:
                                            widget.pageManager.onVolumePressed,
                                        icon: const Icon(
                                          Icons.volume_off,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(70)),
                                    color: const Color.fromARGB(
                                        255, 105, 104, 104),
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(70)),
                                      onTap: widget.pageManager.onVolumePressed,
                                      child: IconButton(
                                        onPressed:
                                            widget.pageManager.onVolumePressed,
                                        icon: const Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: const Color.fromARGB(255, 105, 104, 104),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(70)),
                        onTap: () => setState(() => _isVisible = !_isVisible),
                        child: RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: 1.0).animate(controller),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_isVisible) {
                                  controller.reverse(from: 0.5);
                                } else {
                                  controller.forward(from: 0.0);
                                }

                                _isVisible = !_isVisible;
                              });
                            },
                            icon: const Icon(
                              Icons.navigate_next_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SpeedMusic(_VisitSpeed, size, widget.pageManager),
              const Spacer(),
              Container(
                height: 390,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    kGreenMenu.withOpacity(0.3),
                    kGreendark.withOpacity(0.7),
                    kGreenmeloodark,
                    kGreendarkMenuandbackcolor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(children: [
                  ValueListenableBuilder(
                      valueListenable: widget.pageManager.detailMusicNotifier,
                      builder: (context, MediaItem value, _) {
                        String title = value.title;
                        return Padding(
                            padding: EdgeInsets.only(
                                right: size.width - 200, left: 10),
                            child: Text(
                              title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 28),
                            ));
                      }),
                  ValueListenableBuilder(
                      valueListenable: widget.pageManager.detailMusicNotifier,
                      builder: (context, MediaItem value, _) {
                        String artist = value.artist ?? '';
                        return Padding(
                            padding: EdgeInsets.only(right: size.width - 200),
                            child: Text(
                              artist,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 201, 181, 9),
                                  fontSize: 20),
                            ));
                      }),
                  const Spacer(),
                  Stack(
                    children: [
                      const Image(
                        image: AssetImage('assest/images/background2.png'),
                        height: 150,
                        width: 550,
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: ValueListenableBuilder(
                                  valueListenable:
                                      widget.pageManager.detailMusicNotifier,
                                  builder: (context, MediaItem value, _) {
                                    if (value.artUri.toString() == '-1') {
                                      return const Image(
                                        image: AssetImage(
                                            'assest/images/default5.jpg'),
                                        width: 150,
                                        height: 150,
                                        alignment: Alignment.center,
                                      );
                                    } else {
                                      return FadeInImage(
                                        placeholder: const AssetImage(
                                            'assest/images/default5.jpg'),
                                        image: NetworkImage(
                                            value.artUri.toString()),
                                        width: 150,
                                        height: 150,
                                        alignment: Alignment.center,
                                      );
                                    }
                                  })),
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder<ProgressBarState>(
                      valueListenable: widget.pageManager.progressBarNotifier,
                      builder: (context, value, _) {
                        return ProgressBar(
                          progress: value.current,
                          total: value.total,
                          buffered: value.buffered,
                          onSeek: widget.pageManager.seek,
                          thumbGlowColor: kYellowProgressBarThum,
                          progressBarColor: kYellowProgressBar,
                          baseBarColor: kbaseBarColor,
                          bufferedBarColor: kbufferedColor,
                          thumbColor: kYellowProgressBarThum,
                          timeLabelTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                          backgroundColor: kbuttonColor1,
                          radius: 20,
                          child: CircleAvatar(
                              backgroundColor: kbuttonColor2,
                              radius: 15,
                              child: CircleAvatar(
                                backgroundColor: kbuttonColor3,
                                radius: 12,
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      widget.pageManager.shuffleModeNotifier,
                                  builder: (BuildContext context, bool value,
                                      Widget? child) {
                                    if (value == false) {
                                      return IconButton(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          highlightColor: kbuttonColor1,
                                          color: kbuttonColor2,
                                          disabledColor: kbuttonColor3,
                                          onPressed: widget
                                              .pageManager.onShufflePressed,
                                          icon: const Icon(
                                            Icons.shuffle_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ));
                                    } else {
                                      return IconButton(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          highlightColor: kbuttonColor1,
                                          color: kbuttonColor2,
                                          disabledColor: kbuttonColor3,
                                          onPressed: widget
                                              .pageManager.onShufflePressed,
                                          icon: const Icon(
                                            Icons.shuffle_outlined,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ));
                                    }
                                  },
                                ),
                              ))),
                      CircleAvatar(
                          backgroundColor: kbuttonColor1,
                          radius: 30,
                          child: CircleAvatar(
                              backgroundColor: kbuttonColor2,
                              radius: 25,
                              child: CircleAvatar(
                                  backgroundColor: kbuttonColor3,
                                  radius: 20,
                                  child: GestureDetector(
                                    onTap: (() => setState(
                                          () => isPressedPrevious =
                                              !isPressedPrevious,
                                        )),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kbuttonColor3,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40)),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: blur1,
                                              offset: -distance,
                                              color: color3,
                                              inset: isPressedPrevious,
                                            ),
                                            BoxShadow(
                                              blurRadius: blur1,
                                              offset: distance,
                                              color: color4,
                                              inset: isPressedPrevious,
                                            ),
                                          ]),
                                      child: ValueListenableBuilder(
                                          valueListenable:
                                              widget.pageManager.isfirstone,
                                          builder: (context, bool value, _) {
                                            return IconButton(
                                                onPressed: value
                                                    ? null
                                                    : widget.pageManager
                                                        .onPreviousPressed,
                                                padding: EdgeInsets.zero,
                                                highlightColor: kbuttonColor1,
                                                color: kbuttonColor2,
                                                disabledColor: kbuttonColor3,
                                                icon: Icon(
                                                  Icons.skip_previous,
                                                  color: value
                                                      ? Colors.black
                                                      : Colors.white,
                                                  size: 40,
                                                ));
                                          }),
                                    ),
                                  )))),
                      CircleAvatar(
                          backgroundColor: kbuttonColor1,
                          radius: 40,
                          child: CircleAvatar(
                              backgroundColor: kbuttonColor2,
                              radius: 33,
                              child: GestureDetector(
                                  onTap: (() => setState(
                                        () => isPressed = !isPressed,
                                      )),
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
                                      child: ValueListenableBuilder<
                                              ButtonState>(
                                          valueListenable: widget
                                              .pageManager.bttonStateNotifier,
                                          builder:
                                              (context, ButtonState value, _) {
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
                                                    widget.pageManager.pause();
                                                    setState(
                                                      () => isPressed =
                                                          !isPressed,
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    color: Color.fromARGB(
                                                        255, 207, 158, 8),
                                                    size: 50,
                                                  ),
                                                );
                                              case ButtonState.paused:
                                                return IconButton(
                                                  padding: EdgeInsets.zero,
                                                  highlightColor: kbuttonColor1,
                                                  color: kbuttonColor2,
                                                  disabledColor: kbuttonColor3,
                                                  onPressed: () {
                                                    widget.pageManager.play();
                                                    setState(
                                                      () => isPressed =
                                                          !isPressed,
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.pause,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                );
                                            }
                                          }))))),
                      CircleAvatar(
                          backgroundColor: kbuttonColor1,
                          radius: 30,
                          child: CircleAvatar(
                              backgroundColor: kbuttonColor2,
                              radius: 25,
                              child: GestureDetector(
                                onTap: (() => setState(
                                      () => isPressedSkip = !isPressedSkip,
                                    )),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: kbuttonColor3,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: blur2,
                                            offset: -distance,
                                            color: color5,
                                            inset: isPressedSkip,
                                          ),
                                          BoxShadow(
                                            blurRadius: blur2,
                                            offset: distance,
                                            color: color6,
                                            inset: isPressedSkip,
                                          ),
                                        ]),
                                    child: ValueListenableBuilder(
                                        valueListenable:
                                            widget.pageManager.isLastOne,
                                        builder: (context, bool value, _) {
                                          return IconButton(
                                            padding: EdgeInsets.zero,
                                            highlightColor: kbuttonColor1,
                                            color: kbuttonColor2,
                                            disabledColor: kbuttonColor3,
                                            onPressed: widget
                                                .pageManager.onSkipPressed,
                                            icon: Icon(
                                              Icons.skip_next,
                                              color: value
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 40,
                                            ),
                                          );
                                        })),
                              ))),
                      CircleAvatar(
                        backgroundColor: kbuttonColor1,
                        radius: 20,
                        child: CircleAvatar(
                            backgroundColor: kbuttonColor2,
                            radius: 15,
                            child: CircleAvatar(
                                backgroundColor: kbuttonColor3,
                                radius: 12,
                                child: ValueListenableBuilder(
                                  valueListenable: widget.pageManager.repeate,
                                  builder: (context, RepeatState value, _) {
                                    switch (value) {
                                      case RepeatState.all:
                                        return IconButton(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            highlightColor: kbuttonColor1,
                                            color: kbuttonColor2,
                                            disabledColor: kbuttonColor3,
                                            onPressed: widget
                                                .pageManager.onRepeatPressed,
                                            icon: const Icon(
                                              Icons.repeat,
                                              color: Colors.white,
                                              size: 20,
                                            ));
                                      case RepeatState.one:
                                        return IconButton(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            highlightColor: kbuttonColor1,
                                            color: kbuttonColor2,
                                            disabledColor: kbuttonColor3,
                                            onPressed: widget
                                                .pageManager.onRepeatPressed,
                                            icon: const Icon(
                                              Icons.repeat_one_sharp,
                                              color: Colors.white,
                                              size: 20,
                                            ));
                                      case RepeatState.off:
                                        return IconButton(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            highlightColor: kbuttonColor1,
                                            color: kbuttonColor2,
                                            disabledColor: kbuttonColor3,
                                            onPressed: widget
                                                .pageManager.onRepeatPressed,
                                            icon: const Icon(
                                              Icons.repeat,
                                              color: Colors.black,
                                              size: 20,
                                            ));
                                    }
                                  },
                                ))),
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
