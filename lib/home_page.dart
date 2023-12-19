import 'package:flutter/material.dart';
import 'package:my_enterprise_app/main/main_discovery.dart';
import 'package:my_enterprise_app/main/main_forum.dart';
import 'package:my_enterprise_app/main/main_home.dart';
import 'package:my_enterprise_app/main/main_mine.dart';
import 'package:my_enterprise_app/main/main_tiktok.dart';

/// FileName home_page
///
/// @Author LinGuanYu
/// @Date 2023/12/17 15:08
///
/// @Description 主页

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tabTitleList = ["首页", "论坛", "发现","抖音", "我的"];

  List<String> tabNormalImagesList = [
    "tab1.png",
    "tab2.png",
    "tab3.png",
    "like_icon.png",
    "tab4.png"
  ];

  List<String> tabSelectImagesList = [
    "tab1fill.png",
    "tab2fill.png",
    "tab3fill.png",
    "like_icon_2.png",
    "tab4fill.png",
  ];

  ///当前选中页面
  int selectedIndex = 0;

  ///对应页面
  List<Widget> pageList =  [
    const MainHomePage(),
    MainForumPage(),
    MainDiscoveryPage(),
    MainTikTokPage(),
    MainMinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

        ///不知道为什么，文本的颜色只能从上面属性修改，使用下方的方式无法进行修改
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.red),
        items: [
          BottomNavigationBarItem(
              label: tabTitleList[0],
              icon: Image.asset(
                "images/2.0/${selectedIndex == 0 ? tabSelectImagesList[0] : tabNormalImagesList[0]}",
                width: 26,
                height: 26,
              )),
          BottomNavigationBarItem(
              label: tabTitleList[1],
              icon: Image.asset(
                "images/2.0/${selectedIndex == 1 ? tabSelectImagesList[1] : tabNormalImagesList[1]}",
                width: 26,
                height: 26,
              )),
          BottomNavigationBarItem(
              label: tabTitleList[2],
              icon: Image.asset(
                "images/2.0/${selectedIndex == 2 ? tabSelectImagesList[2] : tabNormalImagesList[2]}",
                width: 26,
                height: 26,
              )),
          BottomNavigationBarItem(
              label: tabTitleList[3],
              icon: Image.asset(
                "images/2.0/${selectedIndex == 3 ? tabSelectImagesList[3] : tabNormalImagesList[3]}",
                width: 26,
                height: 26,
              )),
          BottomNavigationBarItem(
              label: tabTitleList[4],
              icon: Image.asset(
                "images/2.0/${selectedIndex == 4 ? tabSelectImagesList[4] : tabNormalImagesList[4]}",
                width: 26,
                height: 26,
              )),
        ],
      ),
    );
  }
}
