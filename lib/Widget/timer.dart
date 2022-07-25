// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/Controllers/page_manager.dart';

// ignore: must_be_immutable
class TimerCountDown extends StatefulWidget {
  TimerCountDown(this.pagemanager, {Key? key}) : super(key: key);
  PageManager pagemanager;

  @override
  State<TimerCountDown> createState() => _TimerCountDownState();
}

class _TimerCountDownState extends State<TimerCountDown> {
  TimePicker? timepick = TimePicker.zero;
  // ignore: avoid_init_to_null
  Duration valuetime = Duration.zero;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n
        .toString()
        .padLeft(2, '0'); //برای عدد های یک  رقمی در اخر ان صفر بگذارد
    final minute = twoDigits(valuetime.inMinutes.remainder(60));
    final second = twoDigits(valuetime.inSeconds.remainder(60));
    Duration? dur = Duration.zero;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(70)),
      color: const Color.fromARGB(255, 105, 104, 104),
      child: InkWell(
          onTap: () {
            setState(() {
              showAlert();
            });
            print(dur);
          },
          child: valuetime == Duration.zero
              ? IconButton(
                  icon: const Icon(
                    Icons.timer,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      showAlert();
                    });
                  })
              : Container(
                  height: 45,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    color: Color.fromARGB(255, 105, 104, 104),
                  ),
                  child: Center(
                    child: Text(
                      '$minute:$second',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))),
    );
  }

  showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white70,
                title: const Text('Choose Time',
                    style: TextStyle(color: Colors.purple)),
                content: SizedBox(
                  height: 170,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            var value = TimePicker.zero;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            'خاموش',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.zero,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.fivemin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '5 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.fivemin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.tenmin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '10 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.tenmin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.fifteenmin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '15 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.fifteenmin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.twentymin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '20 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.twentymin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.thirtyfivemin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '25 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.twentyfivemin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.thirtymin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '30 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.thirtymin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.thirtyfivemin;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '35 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.thirtyfivemin,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            var value = TimePicker.forty;
                            setState(() {
                              timepick = value;
                            });
                          },
                          title: const Text(
                            '40 min',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          leading: Radio<TimePicker>(
                            value: TimePicker.forty,
                            groupValue: timepick,
                            onChanged: (TimePicker? value) {
                              setState(() {
                                timepick = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('choose',
                        style: TextStyle(color: Colors.purple)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      this.setState(() {
                        switch (timepick!) {
                          case TimePicker.zero:
                            valuetime = Duration.zero;
                            break;
                          case TimePicker.fivemin:
                            valuetime = const Duration(minutes: 5);
                            break;
                          case TimePicker.tenmin:
                            valuetime = const Duration(minutes: 10);
                            break;
                          case TimePicker.fifteenmin:
                            valuetime = const Duration(minutes: 15);
                            break;
                          case TimePicker.twentymin:
                            valuetime = const Duration(minutes: 20);
                            break;
                          case TimePicker.twentyfivemin:
                            valuetime = const Duration(minutes: 25);
                            break;
                          case TimePicker.thirtymin:
                            valuetime = const Duration(minutes: 30);
                            break;
                          case TimePicker.thirtyfivemin:
                            valuetime = const Duration(minutes: 35);
                            break;
                          case TimePicker.forty:
                            valuetime = const Duration(minutes: 40);
                            break;
                        }
                        print(valuetime);
                        startTimer();
                      });
                    },
                  ),
                ],
              ),
            ));
  }

  void startTimer() {
    print('StartTime');
    timer = Timer.periodic(const Duration(seconds: 1), (_) => lessTime());
  }

  lessTime() {
    print('startLessTime');
    const lessSecond = -1;
    setState(() {
      final seconds = valuetime.inSeconds + lessSecond;
      if (valuetime.inMinutes == 0 && seconds < 0) {
        timer?.cancel();
        widget.pagemanager.pause();
      } else {
        valuetime = Duration(seconds: seconds);
      }
      print(seconds);
    });
  }
}

enum TimePicker {
  zero,
  fivemin,
  tenmin,
  fifteenmin,
  twentymin,
  twentyfivemin,
  thirtymin,
  thirtyfivemin,
  forty;
}
