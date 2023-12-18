import 'package:flutter/material.dart';

import 'item/home_item_page3.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;

/// FileName main_discovery
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:29
///
/// @Description 发现

class MainDiscoveryPage extends StatefulWidget {
  const MainDiscoveryPage({super.key});

  @override
  State<MainDiscoveryPage> createState() => _MainDiscoveryPageState();
}

class _MainDiscoveryPageState extends State<MainDiscoveryPage>
    with SingleTickerProviderStateMixin {
  List<String> topTabList = [
    "推荐",
    "动态",
    "flutter",
    "Kotlin",
    "Swift",
    "Java",
    "Python"
  ];

  late TabController tabController;

  List<Widget> bodyPageList = [];

  num bannerIndex = 0;

  List<String> imageList = [
    "https://up.deskcity.org/pic_source/4e/9e/fb/4e9efbb5ac31ad11673fdf8c55e3a6cf.jpg",
    "https://i1.hdslb.com/bfs/archive/2f2f90eafc3877fe335ec27bf763c1ed69d339f5.jpg",
    "https://img2.baidu.com/it/u=625894305,2200048696&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
    "https://i1.hdslb.com/bfs/archive/f8a26868172c149599bd7898562598a756e4af00.jpg",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: topTabList.length, vsync: this);
    for (int pageIndex = 0; pageIndex < topTabList.length; pageIndex++) {
      bodyPageList.add(HomeItemPage3(
          pageTitle: topTabList[pageIndex], pageIndex: pageIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PullToRefreshNotification(
        onRefresh: onRefresh,
        child: extend.ExtendedNestedScrollView(
          headerSliverBuilder: (context, flag) {
            return [
              SliverAppBar(
                expandedHeight: 240,
                flexibleSpace: FlexibleSpaceBar(
                  background: buildBannerFunction(),
                ),

                ///设置SliverAppBar是否固定
                pinned: true,

                ///随着滑动隐藏标题
                floating: true,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline_outlined))
                ],
                bottom: TabBar(
                  ///不写这个会导致第一个标签左侧还有一段空白
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: tabController,
                  tabs: topTabList
                      .map((e) => Tab(
                            text: e,
                          ))
                      .toList(),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: bodyPageList,
          ),
        ),
      ),
    );
  }

  Future<bool> onRefresh() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }

  Widget buildBannerFunction() {
    double swiperHeight = 140;

    return SizedBox(
      height: swiperHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Swiper(
              autoplay: true,
              onIndexChanged: (index) {
                setState(() {
                  bannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return SizedBox(
                  height: swiperHeight,
                  child: Image.network(
                    imageList[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: imageList.length,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              "${bannerIndex + 1}/${imageList.length}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

