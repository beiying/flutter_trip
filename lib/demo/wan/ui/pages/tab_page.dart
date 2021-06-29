import 'package:flutter/material.dart';
import 'package:flutter_trip/demo/wan/model/models.dart';

class TabPage extends StatefulWidget {
  const TabPage(
      {Key key, this.labelId, this.title, this.titleId, this.treeModel})
      : super(key: key);

  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;
  
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(),
    );
  }
}