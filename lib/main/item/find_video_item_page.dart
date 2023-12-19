import 'package:flutter/material.dart';
import 'package:my_enterprise_app/bean/bean_video.dart';

import 'package:video_player/video_player.dart';

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

  ///创建视频播放控制器
  late VideoPlayerController videoPlayerController;
  ///控制更新视频加载初始化完成状态更新
  late Future videoPlayFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("这是视频链接${widget.videoModel.videoUrl}");
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoModel.videoUrl));
    videoPlayFuture = videoPlayerController.initialize().then((value){
      ///视频初始化完成之后，调用播放
      videoPlayerController.play();
      setState(() {

      });
    });
  }


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

  buildVideWidget() {
    return FutureBuilder(future: videoPlayFuture, builder: (context,value){
      if(value.connectionState == ConnectionState.done){

        return InkWell(
          onTap: (){
            ///切换视频播放与暂停
            if(videoPlayerController.value.isInitialized){
              ///视频已经初始化
              if(videoPlayerController.value.isPlaying){
                ///播放变暂停
                videoPlayerController.pause();
              }else{
                ///暂停变播放
                videoPlayerController.play();
              }



            }else{
              videoPlayerController.initialize().then((value){
                videoPlayerController.play();
                setState(() {

                });
              });

            }
          },
          child: Center(
            child: AspectRatio(
              ///设置视频大小
              aspectRatio: videoPlayerController.value.aspectRatio,
              ///播放视频的组件
              child: VideoPlayer(videoPlayerController),
            ),
          ),
        );
      }else{
        ///加载动画
        return Center(
          child: Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(color: Colors.white,),
          ),
        );
      }
    });
  }
}
