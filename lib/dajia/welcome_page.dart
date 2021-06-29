import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_trip/generated/r.dart';

class WelComePage extends StatefulWidget {
  @override
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  bool _shouldShowPrivacyPolicy = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _shouldShowPrivacyPolicy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Image.asset(
              R.images_ic_dajia_launcher,
              fit: BoxFit.scaleDown,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          new Offstage(
            offstage: _shouldShowPrivacyPolicy,
            child: Stack(
              children: [
                Container(color: Colors.black45),
                Center(
                  child: Container(
                      color: Colors.white,
                      width: 343,
                      height: 500,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "温馨提示",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 350,
                              margin: EdgeInsets.only(top: 16.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  "感谢您信任并使用大家中医。我们非常重视保护您的隐私和个人信息，在您使用大家中医App前，请仔细阅读《服务协议》《隐私政策》。我们可能在您使用相关功能或服务时，需要在您的设备中开启特定的访问权限，以实现这些权限所涉及功能可以正常使用，包括：\n" +
                                      "1、在您开启网络权限后，可实现使用网络使用工作室和浏览大家经典内容。\n" +
                                      "2、在您开启系统通知权限后，我们可以向您发送通知。\n" +
                                      "3、在您开启相机权限后，您允许我方访问相机，以便使您可以使用拍摄上传照片和视频，以及使用视频通话功能。\n" +
                                      "4、在您开启存储权限后，您允许我们进行缓存以提升您浏览大家经典模块和使用工作室功能的体验。\n" +
                                      "5、在您开启设备信息权限后，您允许我们获取您的设备信息以作为您设备的唯一性标识，以便向您提供更契合您需求的页面展示和推荐个性化内容。（更多详细信息请参阅隐私政策）\n" +
                                      "\n" +
                                      "上述权限均不会默认开启，我们会在相关的应用场景中向您申请，只有经过您明示授权才会开启、在实现功能或服务时使用，不会在功能或服务不需要时通过您授权的权限收集信息。开启之后您也可以在手机系统设置中关闭或再次打开权限。在您同意并接受后，将可以使用大家中医为您提供的全部功能。",
                                  style: TextStyle(fontSize: 13, height: 1.45),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        exit(0);
                                      },
                                      child: Text(
                                        "不同意",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        _goNext();
                                      },
                                      child: Text(
                                        "同意并继续",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFFCC5641),
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goNext() {
    setState(() {
      _shouldShowPrivacyPolicy = true;
    });
  }
}
