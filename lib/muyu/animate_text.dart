import 'package:flutter/material.dart';

class AnimateText extends StatefulWidget {
  final String text;

  const AnimateText({super.key, required this.text});

  @override
  State<AnimateText> createState() => _FadTextState();
}

class _FadTextState extends State<AnimateText>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  //动画器
  late Animation<double> opacity;
  late Animation<double> scale;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);
    scale = Tween(begin: 1.0, end: 0.8).animate(controller);
    position = Tween<Offset>(begin: Offset(0, 2), end: Offset.zero)
        .animate(controller);
    controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FadeTransition(
  //     opacity: opacity,
  //     child: Text(widget.text),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
          opacity: opacity,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
