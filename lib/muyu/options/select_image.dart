import 'package:first_station/models/imageOption.dart';
import 'package:flutter/material.dart';
class ImageOptionItem extends StatelessWidget {
  //ImageOption对象和bool激活状态
  final ImageOption option;
  final bool active;

  const ImageOptionItem(
      {super.key, required this.option, required this.active});

  @override
  Widget build(BuildContext context) {
    Border activeBorder = Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: !active ? null : activeBorder),
      child: Column(
        children: [
          Text(
            option.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Image.asset(option.src),
          )),
          Text('每次功德 +${option.min}~${option.max}')
        ],
      ),
    );
  }
}
