import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/group/group_content.dart';
import 'package:flutter_douban/pages/mall/mall_content.dart';
import 'package:flutter_douban/pages/profile/profile_content.dart';
import 'package:flutter_douban/pages/subject/subject_content.dart';

import 'home_content.dart';

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

List<Widget> indexStackItems(){
  return [
    HomeContent(),
    SubjectContent(),
    GroupContent(),
    MallContent(),
    ProfileContent()
  ];
}