import 'package:clone_carrot_market/pages/product_list.dart';
import 'package:clone_carrot_market/widget/app_bar.dart';
import 'package:clone_carrot_market/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  void changeIndexFunction(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: _bodyWidget(),
      bottomNavigationBar:
          myBottomNavigationBar(_currentPageIndex, changeIndexFunction),
    );
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return ProductList();
    }

    return Container();
  }
}
