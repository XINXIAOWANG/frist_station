import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;

  final TextEditingController controller;

  const GuessAppBar(
      {super.key, required this.onCheck, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu, color: Colors.black),
      actions: [
        IconButton(
            splashRadius: 20,
            onPressed: onCheck,
            icon: const Icon(
              Icons.run_circle_outlined,
              color: Colors.blue,
            ))
      ],
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF3F6F9),
            constraints: BoxConstraints(maxHeight: 35),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            hintText: "输入 0~99 数字",
            hintStyle: TextStyle(fontSize: 14)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
