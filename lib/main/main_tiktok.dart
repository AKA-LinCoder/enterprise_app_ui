import 'package:flutter/material.dart';

/// FileName main_find
///
/// @Author LinGuanYu
/// @Date 2023/12/19 08:58
///
/// @Description 抖音

class MainTikTokPage extends StatefulWidget {
  const MainTikTokPage({super.key});

  @override
  State<MainTikTokPage> createState() => _MainTikTokPageState();
}

class _MainTikTokPageState extends State<MainTikTokPage>
    with SingleTickerProviderStateMixin {
  List<String> tabTextList = ["关注", "推荐"];
  List<Tab> tabWidgetList = [];

  late TabController tabController;


  List<String> videoList = [

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in tabTextList) {
      tabWidgetList.add(Tab(text: element));
    }
    // tabTextList.map((e) => tabWidgetList.add(Tab(text:e.toString())));
    tabController = TabController(length: tabTextList.length, vsync: this);

    for(int i = 0;i <10;i++){
      videoList.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///黑色背景
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                color: Colors.black,
              )),

          ///主体视图
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: buildTableViewWidget()),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 54,
              child: buildTabBarWidget()),
        ],
      ),
    );
  }

  buildTableViewWidget() {
    return TabBarView(
        controller: tabController,
        children: tabTextList.map((e) => buildTableViewItemWidget(e)).toList());
  }

  buildTabBarWidget() {
    return Container(
      ///对齐在顶部
      alignment: Alignment.topCenter,
      child: TabBar(
        tabAlignment: TabAlignment.center,

        ///取消下面的divider
        dividerHeight: 0,
        ///设置之后就不会平分宽度
        isScrollable: true,
        // padding: EdgeInsets.zero,
        controller: tabController,
        indicatorColor: Colors.white,
        ///指示器宽度与文字一样
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabWidgetList, labelColor: Colors.white,
      ),
    );
  }

  ///用来实现上下滑动的页面
  Widget buildTableViewItemWidget(String e) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          return buildPageViewItemWidget(e, index);
        });
  }

  ///页面主要内容显示区域
  buildPageViewItemWidget(String value, int index) {
    return Center(
      child: Text(
        value + index.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
