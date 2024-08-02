import 'package:first_station/home/menu.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  //需要的数据
  //传入激活的索引,点击回调,菜单数据列表
  final int currentIndex;
  final List<MenuData> menus;
  final ValueChanged? onItemTap;

  const AppBottomBar(
      {super.key, this.currentIndex = 0, required this.menus, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: Colors.white,
      onTap: onItemTap,
      currentIndex: currentIndex,
      elevation: 3,
      iconSize: 22,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: menus.map(_buildItemByMenuMate).toList(),
    );
  }

  BottomNavigationBarItem _buildItemByMenuMate(MenuData menu) {
    return BottomNavigationBarItem(label: menu.lable, icon: Icon(menu.icon));
  }
}
