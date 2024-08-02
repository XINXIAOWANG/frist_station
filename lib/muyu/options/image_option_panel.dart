import 'package:first_station/models/imageOption.dart';
import 'package:first_station/muyu/options/select_image.dart';
import 'package:flutter/material.dart';

class ImageOptionPanel extends StatelessWidget {
  final List<ImageOption> imageOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const ImageOptionPanel(
      {super.key,
      required this.imageOptions,
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
              height: 46,
              alignment: Alignment.center,
              child: Text(
                "选择木鱼",
                style: lableStyle,
              ),
            ),
            Expanded(
                child: Padding(
              padding: padding,
              child: Row(
                children: [
                  Expanded(child: _buildByIndex(0)),
                  Expanded(child: _buildByIndex(1)),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: ImageOptionItem(option: imageOptions[index], active: active),
    );
  }
}
