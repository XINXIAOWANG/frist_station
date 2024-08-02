import 'package:first_station/net_acticle/view/article_content.dart';
import 'package:flutter/material.dart';

class NetArticlePage extends StatelessWidget {
  const NetArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络请求测试'),
      ),
      body: const ArticleContent(),
    );
  }
}
