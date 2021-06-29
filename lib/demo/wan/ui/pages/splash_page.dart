import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/demo/common.dart';
import 'package:flutter_trip/demo/http_utils.dart';
import 'package:flutter_trip/demo/navigator_util.dart';
import 'package:flutter_trip/demo/wan/model/models.dart';
import 'package:flutter_trip/demo/wan/res/strings.dart';
import 'package:flutter_trip/utils/utils.dart';
import 'package:rxdart/rxdart.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;
  List<String> _guideList = [
    Utils.getImagePath('guide1'),
    Utils.getImagePath('guide2'),
    Utils.getImagePath('guide3'),
    Utils.getImagePath('guide4'),
  ];
  List<Widget> _bannerList = new List();
  int _status = 0;
  int _count = 3;
  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? new Container()
                : new Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                        radius: 4.0,
                        padding: EdgeInsets.only(bottom: 30.0),
                        itemColor: Colors.black26),
                    children: _bannerList),
          ),
          _buildAdWidget(),
          new Offstage(
            offstage: !(_status == 1),
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      IntlUtil.getString(context, Ids.jump_count,
                          params: ['$_count']),
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Colours.divider)),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashBg() {
    return new Image.asset(Utils.getImagePath("splash_bg"),
        width: double.infinity, fit: BoxFit.fill, height: double.infinity);
  }

  Widget _buildAdWidget() {
    if (_splashModel == null) {
      return new Container(height: 0.0,);
    }
    return new Offstage(
      offstage: !(_status == 1),
      child: new InkWell(
        onTap: () {
          if (ObjectUtil.isEmpty(_splashModel.url)) return;
          _goMain();
          NavigatorUtil.pushWeb(context, title: _splashModel.title, url: _splashModel.url);
        },
        child: new Container(
          alignment: Alignment.center,
          child: new CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: _splashModel.imgUrl,
            placeholder: (context, url) => _buildSplashBg(),
            errorWidget: (context, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  void _init() {
    _loadSplashData();
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((event) {
      if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  void _loadSplashData() {
    _splashModel = SpUtil.getObj(
        Constant.key_splash_model, (v) => SplashModel.fromJson(v));
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtils httpUtils = HttpUtils();
    httpUtils.getSplash().then((model) {
      if (!ObjectUtil.isEmpty(model.imgUrl)) {
        if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
          SpUtil.putObject(Constant.key_splash_model, model);
          setState(() {
            _splashModel = model;
          });
        }
      } else {
        SpUtil.putObject(Constant.key_splash_model, null);
      }
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: new InkWell(
                    onTap: () {
                      _goMain();
                    },
                    child: new CircleAvatar(
                      radius: 48.0,
                      backgroundColor: Colors.indigoAccent,
                      child: new Padding(
                        padding: EdgeInsets.all(2.0),
                        child: new Text(
                          "立即体验",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _initSplash() {
    if (_splashModel == null) {
      _goMain();
    } else {
      _doCountDown();
    }
  }

  void _goMain() {}

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }
}
