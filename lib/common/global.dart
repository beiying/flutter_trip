
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Global {
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance();
    callback();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    }
  }
}