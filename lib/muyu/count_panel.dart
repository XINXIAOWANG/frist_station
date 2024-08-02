import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {
  //需要的数据
  //count;onTapSwitchAudio;onTapSwitchImage
  final int count;
  final VoidCallback onTapSwitchAudio;
  final VoidCallback onTapSwitchImage;

  const CountPanel(
      {super.key,
      required this.count,
      required this.onTapSwitchAudio,
      required this.onTapSwitchImage});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        minimumSize: Size(36, 36),
        padding: EdgeInsets.zero, //边距
        backgroundColor: Colors.green,
        elevation: 0 //阴影深度
        );
    return Stack(children: [
      Center(
        child: Text(
          '功德数 : ${count}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      Positioned(
        right: 10,
        top: 10,
        child: Wrap(
          spacing: 4,
          direction: Axis.vertical,
          children: [
            ElevatedButton(
              onPressed: onTapSwitchAudio,
              child: Icon(Icons.music_note_outlined),
              style: style,
            ),
            ElevatedButton(
                onPressed: onTapSwitchImage,
                child: Icon(Icons.image),
                style: style)
          ],
        ),
      )
    ]);
  }
}
