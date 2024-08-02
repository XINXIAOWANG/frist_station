import 'package:flutter/material.dart';

class ConformDialog extends StatelessWidget {
  //数据  标题,消息内容,按钮
  final String title;
  final String msg;
  final String conformText;
  final VoidCallback onConform;

  const ConformDialog(
      {super.key,
      required this.title,
      required this.msg,
      this.conformText = '删除',
      required this.onConform});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            _buildMessage(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _buildMessage() => Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Text(
          msg,
          style: const TextStyle(fontSize: 14),
        ),
      );

  Widget _buildButtons(BuildContext context) => Row(
        children: [
          const Spacer(),
          OutlinedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text(
                '取消',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onConform,
            child: Text(conformText),
          ),
        ],
      );
}
