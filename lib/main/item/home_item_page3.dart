/// FileName home_item_page3
///
/// @Author LinGuanYu
/// @Date 2023/12/18 13:49
///
/// @Description

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


class HomeItemPage3 extends StatefulWidget {
  final num pageIndex;
  final String pageTitle;

  const HomeItemPage3(
      {super.key, required this.pageTitle, required this.pageIndex});

  @override
  State<HomeItemPage3> createState() => _HomeItemPage3State();
}

class _HomeItemPage3State extends State<HomeItemPage3> {
  List<String> imageList = [
    "https://up.deskcity.org/pic_source/4e/9e/fb/4e9efbb5ac31ad11673fdf8c55e3a6cf.jpg",
    "https://i1.hdslb.com/bfs/archive/2f2f90eafc3877fe335ec27bf763c1ed69d339f5.jpg",
    "https://img2.baidu.com/it/u=625894305,2200048696&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
    "https://i1.hdslb.com/bfs/archive/f8a26868172c149599bd7898562598a756e4af00.jpg",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
  ];

  num bannerIndex = 0;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);



  final LoadIndicator refreshFooter = const ClassicFooter(
    loadingText: "加载中",
    noDataText: "没有更多数据",
    failedText: "加载失败",
    canLoadingText: "释放加载",
    idleText: "上拉加载更多",
  );

  final Widget refreshHeader = const ClassicHeader(
    refreshingText: "刷新中",
    releaseText: "松开刷新",
    idleText: "松开刷新数据",
    failedText: "刷新失败",
    completeText: "刷新完成",
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: buildListView(),
    );
  }





  Widget buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Container(
            height: 130,
            margin: const EdgeInsets.only(top: 5),
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "我是标题",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容"
                      "我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容v我是内容我是内容",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Text(
                      "海贼王路飞",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 15,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "16",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.share_outlined,
                      size: 15,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "52",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  // Widget buildBannerFunction() {
  //   double swiperHeight = 140;
  //
  //   return SizedBox(
  //     height: swiperHeight,
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           left: 0,
  //           right: 0,
  //           bottom: 0,
  //           top: 0,
  //           child: Swiper(
  //             autoplay: true,
  //             onIndexChanged: (index) {
  //               setState(() {
  //                 bannerIndex = index;
  //               });
  //             },
  //             itemBuilder: (context, index) {
  //               return SizedBox(
  //                 height: swiperHeight,
  //                 child: Image.network(
  //                   imageList[index],
  //                   fit: BoxFit.fill,
  //                 ),
  //               );
  //             },
  //             itemCount: imageList.length,
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 10,
  //           right: 10,
  //           child: Text(
  //             "${bannerIndex + 1}/${imageList.length}",
  //             style: const TextStyle(
  //                 color: Colors.white, fontWeight: FontWeight.bold),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  ///@title onRefresh
  ///@description 下拉刷新
  ///@updateTime 2023/12/18 11:22
  ///@author LinGuanYu
  onRefresh() async {
    Future.delayed(const Duration(seconds: 3), () {
      refreshController.refreshCompleted();
    });
  }

  ///@title onLoading
  ///@description 上拉加载
  ///@updateTime 2023/12/18 11:22
  ///@author LinGuanYu
  onLoading() async {
    Future.delayed(const Duration(seconds: 3), () {
      refreshController.loadComplete();
    });
  }
}
