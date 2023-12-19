import 'package:flutter/material.dart';
import 'package:my_enterprise_app/bean/bean_video.dart';
import 'package:my_enterprise_app/main/item/find_video_item_page.dart';

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


  ///推荐
  List<VideoModel> videoList = [];

  ///关注
  List<VideoModel> videoList2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in tabTextList) {
      tabWidgetList.add(Tab(text: element));
    }
    // tabTextList.map((e) => tabWidgetList.add(Tab(text:e.toString())));
    tabController = TabController(length: tabTextList.length, vsync: this);

    for (int i = 0; i < 10; i++) {
      VideoModel videoModel = VideoModel();
      videoModel.videoName = "推荐测试数据$i";
      videoModel.pariseCount = i * 22;
      if (i % 3 == 0) {
        videoModel.isAttention = true;
        videoModel.isLike = true;
      } else {
        videoModel.isAttention = false;
        videoModel.isLike = false;
      }
      videoModel.videoImag =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582996017736&di=101751f6d5b16e03d501001ca62633d4&imgtype=0&src=http%3A%2F%2Fupload.idcquan.com%2F2018%2F0125%2F1516851762394.jpg";
      videoModel.videoUrl =
      "http://111.9.131.75:9520/seismic/2023/12/07/53633817_20231207095239A029.mp4";

      videoList.add(videoModel);
    }

    for (int i = 0; i < 3; i++) {
      VideoModel videoModel =  VideoModel();
      videoModel.videoName = "关注测试数据$i";
      videoModel.pariseCount = i * 22;
      videoModel.isAttention = true;
      if (i % 3 == 0) {
        videoModel.isLike = true;
      } else {
        videoModel.isLike = false;
      }
      videoModel.videoImag =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582996017736&di=101751f6d5b16e03d501001ca62633d4&imgtype=0&src=http%3A%2F%2Fupload.idcquan.com%2F2018%2F0125%2F1516851762394.jpg";
      videoModel.videoUrl =
      "http://111.9.131.75:9520/seismic/2023/12/07/53633817_20231207095239A029.mp4";

      videoList2.add(videoModel);
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
    List<VideoModel> list =[];
    if(e == "推荐"){
      list= videoList;
    }else{
      list = videoList2;
    }
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          VideoModel videoModel = list[index];
          return buildPageViewItemWidget(e, videoModel);
        });
  }

  ///页面主要内容显示区域
  buildPageViewItemWidget(String value, VideoModel videoModel) {
    return FindVideoItemPage(value,videoModel);
  }
}
