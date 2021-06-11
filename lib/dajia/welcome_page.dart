import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_trip/generated/r.dart';

class WelComePage extends StatefulWidget {
  @override
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(R.images_ic_dajia_launcher,
        fit: BoxFit.scaleDown,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
