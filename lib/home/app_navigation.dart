import 'package:first_station/home/app_bottom_bar.dart';
import 'package:first_station/draw/paper.dart';
import 'package:first_station/guess/guess_page.dart';
import 'package:first_station/home/menu.dart';
import 'package:first_station/muyu/muyu_page.dart';
import 'package:first_station/net_acticle/view/net_article_page.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final List<MenuData> menus = [
    MenuData(lable: '猜数字', icon: Icons.question_mark),
    MenuData(lable: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(lable: '白板绘制', icon: Icons.palette_outlined),
    MenuData(lable: '网络文章', icon: Icons.article_outlined),
  ];
  final PageController _ctrl = PageController();

  //上下结构,上:内容  下:导航栏,   使用组件Column
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildContent(_index)),
        AppBottomBar(
          currentIndex: _index,
          menus: menus,
          onItemTap: _onChangePage,
        )
      ],
    );
  }

  void _onChangePage(value) {
    _ctrl.jumpToPage(value);
    setState(() {
      _index = value;
    });
  }

  Widget _buildContent(int index) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _ctrl,
      children: const [
        GuessPage(),
        MuyuPage(),
        Paper(),
        NetArticlePage(),
      ],
    );
  }
// Widget _buildContent(int index) {
//   switch (index) {
//     case 0:
//       return GuessPage();
//     case 1:
//       return MuyuPage();
//     case 2:
//       return Paper();
//     default:
//       return SizedBox.shrink();
//   }
// }
}
