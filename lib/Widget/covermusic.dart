import 'package:flutter/material.dart';

class CoverMusic extends StatefulWidget {
  const CoverMusic({Key? key}) : super(key: key);

  @override
  State<CoverMusic> createState() => _CoverMusicState();
}

class _CoverMusicState extends State<CoverMusic> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: Image(
            image: AssetImage('assest/images/reyhanna.png'),
            width: 140,
            height: 140,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
