import 'package:flutter/material.dart';
import 'package:my_enterprise_app/base/base_page.dart';
import 'package:my_enterprise_app/guid_page.dart';
import 'package:my_enterprise_app/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flustars/flustars.dart';
/// FileName index_page
///
/// @Author LinGuanYu
/// @Date 2023/12/17 14:04
///
/// @Description 应用程序启动页面

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends BasePage<IndexPage> {
  String isFirstUseKey = "echo_is_first";

  bool? echoIsFirst;

  ///是否显示背景图
  bool echoIsShowBg = false;


  late TimerUtil echoTimerUtil;
  num echoTick = 0;

  @override
  void initState() {
    ///mInterval 时间间隔
    ///mTotalTime 总共倒计时
    echoTimerUtil = TimerUtil(mInterval: 1000,mTotalTime: 5000);
    ///计时回调
    echoTimerUtil.setOnTimerTickCallback((millisUntilFinished) {
      setState(() {
        echoTick = millisUntilFinished/1000;
        if(echoTick==0){
          ///跳转首页
          pushReplacePage(const HomePage());
        }
      });
    });
    // 本地数据缓存加载
    super.initState();
    readCacheData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildWelcomeBg(),
          buildTimerProgress(),
          buildLoadingProgress(),
          Positioned(
              bottom: 30.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "images/2.0/logo.jpg",
                      width: 33.0,
                      height: 33.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 14.0,
                  ),
                  const Text("echo 欢迎您")
                ],
              ))
        ],
      ),
    );
  }

  ///读取缓存数据
  void readCacheData() async {
    //读取数据
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ///是否第一次使用
    echoIsFirst = sharedPreferences.getBool(isFirstUseKey);
    if (echoIsFirst == null || echoIsFirst == false) {
      ///第一次使用
      ///去引导页
      sharedPreferences.setBool(isFirstUseKey, true);
      pushReplacePage(const GuidPage());
    } else {
      ///非第一次使用
      ///显示倒计时
      echoIsShowBg = true;
      echoTimerUtil.startCountDown();
    }
    setState(() {});
  }

  ///构建背景
  buildWelcomeBg() {
    if (echoIsShowBg) {
      return Image.asset("images/2.0/welcome_bg.jpeg");
    } else {
      return Container();
    }
  }

  ///构建倒计时的圆形进度
  buildTimerProgress() {
    return  Positioned(
        right: 20.0,
        bottom: 20,
        child: InkWell(
          onTap: (){
            if(echoTimerUtil.isActive()){
              ///关闭倒计时
              echoTimerUtil.cancel();
            }
            pushReplacePage(const HomePage());
          },
          child: SizedBox(
            width: 55.0,
            height: 55.0,
            child: Stack(
              children: [
                 Center(child: CircularProgressIndicator(
                  //0.0-1.0
                  value: echoTick==5.0?0.0:(5.0-echoTick)/5.0,
                )),
                Center(
                  child: Text("${echoTick.toInt()}s"),
                )
              ],
            ),
          ),
        ));
  }

  ///构建加载中间进度
  buildLoadingProgress() {
    if(echoIsShowBg){
      return Container();
    }else{
      return const Positioned(
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
