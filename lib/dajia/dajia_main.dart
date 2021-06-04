
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_trip/dajia/tab_navigator.dart';

class DjApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "大家中医",
      home: TabNavigator(),
    );
  }

}