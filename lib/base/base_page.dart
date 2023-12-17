import 'package:flutter/material.dart';
import 'package:my_enterprise_app/packages/route_util.dart';

/// FileName base_page
///
/// @Author LinGuanYu
/// @Date 2023/12/17 15:19
///
/// @Description 基类

abstract class BasePage<T extends StatefulWidget> extends State<T>{

  void pushPage(Widget page){
    RouteUtil.pushPage(context, page);
  }


  void pushReplacePage(Widget page){
    RouteUtil.pushReplacePage(context, page);
  }

  void popPage(){
    RouteUtil.popPage(context);
  }

}