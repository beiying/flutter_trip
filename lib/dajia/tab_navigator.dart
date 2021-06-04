import 'package:flutter/material.dart';
import 'package:flutter_trip/dajia/pages/classic_page.dart';
import 'package:flutter_trip/dajia/pages/sessions_page.dart';
import 'package:flutter_trip/dajia/pages/studio_page.dart';
import 'package:flutter_trip/dajia/pages/user_page.dart';
import 'package:flutter_trip/generated/r.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          StudioPage(),//工作室
          SessionsPage(),//咨询
          ClassicPage(),//经典
          UserPage()//我的
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_studio_default),
                activeIcon: Image.asset(R.images_ic_main_studio_selected),
                label: "工作室"),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_session_default),
                activeIcon: Image.asset(R.images_ic_main_session_selected),
                label: "咨询"),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_classic_default),
                activeIcon: Image.asset(R.images_ic_main_classic_selected),
                label: "经典"),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_my_default),
                activeIcon: Image.asset(R.images_ic_main_my_selected),
                label: "我的")
          ]),
    );
  }
}
