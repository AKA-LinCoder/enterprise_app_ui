import 'package:flutter/material.dart';
import 'package:my_enterprise_app/bean/bean_video.dart';

/// FileName find_video_item_page
///
/// @Author LinGuanYu
/// @Date 2023/12/19 10:53
///
/// @Description 视频播放页面

class FindVideoItemPage extends StatefulWidget {
  final String tabValue;
  final VideoModel videoModel;
  const FindVideoItemPage(this.tabValue, this.videoModel, {super.key});

  @override
  State<FindVideoItemPage> createState() => _FindVideoItemPageState();
}

class _FindVideoItemPageState extends State<FindVideoItemPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///播放视频
        buildVideWidget(),
        ///播放按钮
        ///视频简介
        ///右侧用户信息按钮
      ],
    );
  }

  buildVideWidget() {}
}
