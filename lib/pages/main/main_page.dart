import 'package:flutter/material.dart';

import 'main_items.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: indexStackItems(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items(),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
