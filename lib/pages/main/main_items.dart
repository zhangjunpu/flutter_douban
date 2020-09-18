import 'package:flutter/material.dart';

import '../group/group.dart';
import '../home/home.dart';
import '../mall/mall.dart';
import '../profile/profile.dart';
import '../subject/subject.dart';

BottomNavigationBarItem item(String name, String iconName) {
  return BottomNavigationBarItem(
    icon: Image.asset(
      "assets/images/tabbar/$iconName.png",
      width: 30,
      height: 30,
    ),
    title: Text(name),
    activeIcon: Image.asset(
      "assets/images/tabbar/${iconName}_active.png",
      width: 30,
      height: 30,
    ),
  );
}

List<BottomNavigationBarItem> items() {
  return [
    item("首页", "home"),
    item("书影音", "subject"),
    item("小组", "group"),
    item("市集", "mall"),
    item("我的", "profile"),
  ];
}

List<Widget> pages() {
  return [
    HomePage(),
    SubjectPage(),
    GroupPage(),
    MallPage(),
    ProfilePage(),
  ];
}
