import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  final Color color;
  final String text;
  final AnimationController controller;

  const ResultNotice(
      {super.key,
      required this.color,
      required this.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) => Text(
            text,
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
