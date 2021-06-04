import 'package:flutter/material.dart';
import 'package:flutter_trip/generated/r.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

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
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
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
                title: Text("工作室",
                    style: TextStyle(
                        color: _currentIndex != 0
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_session_default),
                activeIcon: Image.asset(R.images_ic_main_session_selected),
                title: Text("咨询",
                    style: TextStyle(
                        color: _currentIndex != 1
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_classic_default),
                activeIcon: Image.asset(R.images_ic_main_classic_selected),
                title: Text("经典",
                    style: TextStyle(
                        color: _currentIndex != 2
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Image.asset(R.images_ic_main_my_default),
                activeIcon: Image.asset(R.images_ic_main_my_selected),
                title: Text("我的",
                    style: TextStyle(
                        color:
                            _currentIndex != 3 ? _defaultColor : _activeColor)))
          ]),
    );
  }
}
