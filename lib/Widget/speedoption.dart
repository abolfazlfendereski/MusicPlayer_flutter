// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:selection_wave_slider/selection_wave_slider.dart';

import '../Controllers/page_manager.dart';

// ignore: depend_on_referenced_packages

class SpeedMusic extends StatefulWidget {
  const SpeedMusic(this._visibleSpeed, this.size, this.pageManager, {Key? key})
      : super(key: key);
  final bool _visibleSpeed;
  final Size size;
  final PageManager pageManager;
  @override
  State<SpeedMusic> createState() => _SpeedMusic();
}

class _SpeedMusic extends State<SpeedMusic> {
  double _value = 1.0;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget._visibleSpeed,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        alignment: Alignment.center,
        width: widget.size.width,
        height: 170,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                      width: 380,
                      child: WaveSliderWithDragPoint(
                        dragButton: Container(
                          color: Colors.indigo[900],
                        ),
                        sliderHeight: 80,
                        sliderPointColor: Colors.blueGrey[900],
                        sliderPointBorderColor: Colors.black,
                        sliderColor: Colors.black,
                        toolTipBackgroundColor: Colors.white,
                        toolTipTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        selected: 2,
                        onSelected: (newvalue) {
                          setState(() {
                            var speed = speedChoose(newvalue);
                            print(speed);
                            widget.pageManager.setSpeed(speed);
                          });
                        },
                        optionToChoose: const [
                          "0.25X",
                          "0.5X",
                          "1.0X",
                          "1.25X",
                          "1.5X",
                          "1.75X",
                          "2.0X",
                          "2.25X",
                          "2.5X",
                        ],
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white70),
                height: 45,
                width: 120.0,
                child: Center(
                  child: Text(
                    '$_value',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double speedChoose(int value) {
    switch (value) {
      case 0:
        _value = 0.25;
        break;
      case 1:
        _value = 0.5;
        break;
      case 2:
        _value = 1.0;
        break;
      case 3:
        _value = 1.25;
        break;
      case 4:
        _value = 1.5;
        break;
      case 5:
        _value = 1.75;
        break;
      case 6:
        _value = 2.0;
        break;
      case 7:
        _value = 2.25;
        break;
      case 8:
        _value = 2.5;
        break;
        print(_value);
    }

    return _value;
  }
}
