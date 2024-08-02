import 'package:flutter/material.dart';

class StorkWidthSelector extends StatelessWidget {
  //需要的数据   支持线宽的列表List<double>  激活索引int,条目的颜色,点击条目时的回调
  final List<double> supportStorkWidths;
  final int activeIndex;
  final Color color;
  final ValueChanged<int> onSelect;

  const StorkWidthSelector(
      {super.key,
      required this.supportStorkWidths,
      required this.activeIndex,
      required this.color,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(supportStorkWidths.length, _buldByIndex),
      ),
    );
  }

  Widget _buldByIndex(int index) {
    bool select = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: select ? Border.all(color: Colors.blue) : null,
        ),
        child: Container(
          width: 50,
          color: color,
          height: supportStorkWidths[index],
        ),
      ),
    );
  }
}
