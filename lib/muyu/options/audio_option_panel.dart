import 'package:first_station/models/audioOption.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AudioOptionPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const AudioOptionPanel(
      {super.key,
      required this.audioOptions,
      required this.onSelect,
      required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final TextStyle lableStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    final EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 8, vertical: 16);
    return Material(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            Container(
                child: Text(
              '选择音效',
              style: lableStyle,
            )),
            ...List.generate(audioOptions.length, _buildByIndex)
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return ListTile(
      selected: active,
      onTap: () => onSelect(index),
      title: Text(audioOptions[index].name),
      trailing: IconButton(
        splashRadius: 20,
        onPressed: () => _tempPlay(audioOptions[index].str),
        icon: Icon(Icons.record_voice_over_rounded),
      ),
    );
  }

  void _tempPlay(String str) async {
    AudioPool pool = await FlameAudio.createPool(str, maxPlayers: 1);
    pool.start();
  }
}
