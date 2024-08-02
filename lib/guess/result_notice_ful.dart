import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  final Color color;
  final String text;

  const ResultNotice({
    super.key,
    required this.color, required this.text,
  });

  @override
  State<ResultNotice> createState() => _ResultNoticeState();
}

class _ResultNoticeState extends State<ResultNotice>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //初始化controller对象
    controller =
        AnimationController(vsync: this, duration: Duration(microseconds: 200));
    //启动动画器
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    controller.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: widget.color,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) => Text(
            widget.text,
            style: TextStyle(
                fontSize: 54 * (controller.value),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
