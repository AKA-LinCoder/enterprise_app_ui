
///3.3 bottomNavigationBar配制底部导航栏菜单
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///应用入口 
main() =>
    runApp(MaterialApp(
      home: FirstPage(),),);

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstThemState();
  }
}
class FirstThemState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    ///Scaffold 用来搭建页面的主体结构
    return Scaffold(
      ///页面的头部
      appBar: AppBar(title: Text("标题"),),
      ///页面的主内容区
      ///可以是单独的StatefulWidget 也可以是当前页面构建的如Text文本组件
      body: Center(child: Text("当前选中的页面是$_tabIndex"),),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  ///选中的标签
  int _tabIndex =0;
  ///图标区
  List<Icon> normalIcon = [
    Icon(Icons.home),
    Icon(Icons.message),
    Icon(Icons.people)
  ];

  List<String> normalTitle =[
    "首页",
    "消息",
    "我的"
  ];

  ///构建底部导航栏
  BottomNavigationBar buildBottomNavigation(){

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: normalIcon[0], label: normalTitle[0]),
        BottomNavigationBarItem(
            icon:  normalIcon[1], label: normalTitle[1]),
        BottomNavigationBarItem(
            icon:  normalIcon[2], label: normalTitle[2]),
      ],
      ///显示效果
      type: BottomNavigationBarType.shifting,
      ///当前选中的页面
      currentIndex: _tabIndex,
      ///导航栏的背景颜色
      backgroundColor: Colors.white,
      ///选中时图标与文字的颜色
//      fixedColor: Colors.deepPurple,
      ///选中时图标与文字的颜色
      selectedItemColor: Colors.blue,
      ///未选中时图标与文字的颜色
      unselectedItemColor: Colors.grey,
      ///图标的大小
      iconSize: 24.0,
      ///点击事件
      onTap: (index) {
        setState(() {
          _tabIndex = index;
        });
      },
    );
  }
}


