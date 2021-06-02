import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBar myBottomNavigationBar(int index, Function function) {
  late final Function changeIndex = function;

  return BottomNavigationBar(
    items: _bottomNavigationBarItems(),
    onTap: (index) => changeIndex(index),
    currentIndex: index,
  );
}

List<BottomNavigationBarItem> _bottomNavigationBarItems() {
  return [
    _bottomNavigationBarItem('home', 'Market'),
    _bottomNavigationBarItem('notes', '동네생활'),
    _bottomNavigationBarItem('location', '내 근처'),
    _bottomNavigationBarItem('chat', '채팅'),
    _bottomNavigationBarItem('user', '나의 당근'),
  ];
}

BottomNavigationBarItem _bottomNavigationBarItem(String iconName, String name) {
  double _svgSize = 22;
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      'assets/svg/${iconName}_off.svg',
      width: _svgSize,
    ),
    activeIcon: SvgPicture.asset(
      'assets/svg/${iconName}_on.svg',
      width: _svgSize,
    ),
    label: name,
    backgroundColor: Colors.orange,
  );
}
