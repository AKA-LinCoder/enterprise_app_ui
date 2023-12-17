
import 'package:flutter/material.dart';

/// FileName route_util
///
/// @Author LinGuanYu
/// @Date 2023/12/17 15:12
///
/// @Description 路由工具

class RouteUtil{

  static void pushPage(BuildContext context,Widget page){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> page));
  }

  ///替换跳转页面
  static void pushReplacePage(BuildContext context,Widget page){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> page));
  }

  ///关闭当前显示页面
  static void popPage(BuildContext context){
    Navigator.of(context).pop();
  }
}