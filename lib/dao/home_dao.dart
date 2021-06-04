import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

class HomeDao {
  static const String HOME_URL = "https://www.devio.org/io/flutter_app/json/home_page.json";
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    var file = File("");
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复接口数据中中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.formJson(result);
    } else {
      throw Exception("Failed to load home_page.json");
    }
  }
}