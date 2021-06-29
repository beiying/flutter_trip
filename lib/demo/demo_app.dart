import 'package:base_library/base_library.dart';
import 'package:dio/dio.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common.dart';
import 'common/colors.dart';
import 'common/sp_helper.dart';
import 'wan/bloc/application_bloc.dart';
import 'wan/bloc/bloc_provider.dart';
import 'wan/model/models.dart';
import 'wan/res/strings.dart';
import 'wan/ui/pages/main_page.dart';
import 'wan/ui/pages/splash_page.dart';

class DemoApp extends StatefulWidget {
  DemoApp({Key key}) : super(key: key);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  Locale _locale;
  Color _themeColor = Colours.app_main;
  @override
  void initState() {
    super.initState();
    setInitDir(initStorageDir: true);
    setLocalizedValues(localizedValues);
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        BaseConstant.routeMain: (ctx) => MainPage(),
      },
      home: SplashPage(),
      theme: ThemeData.light().copyWith(
        brightness: Brightness.dark,
        primaryColor: _themeColor,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }

  void init() {
    _init();
    _initListener();
    _loadLocale();
  }

  void _init() {
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.server_address;
    String cookie = SpUtil.getString(BaseConstant.keyAppToken);
    if (ObjectUtil.isNotEmpty(cookie)) {
      Map<String, dynamic> _headers = new Map();
      _headers["Cookie"] = cookie;
      options.headers = _headers;
    }
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((event) {
      _loadLocale();
    });
  }

  void _loadLocale() {
    setState(() {
      LanguageModel model = SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
