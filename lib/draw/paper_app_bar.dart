import 'package:flutter/material.dart';

///抽离的头部组件
class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;

  const PaperAppBar({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('白板绘制'),
      actions: [
        IconButton(
            onPressed: onClear, icon: Icon(Icons.delete_outline_rounded))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
