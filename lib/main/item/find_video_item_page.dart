import 'package:flutter/material.dart';
import 'package:my_enterprise_app/bean/bean_video.dart';
import 'package:my_enterprise_app/main/item/video_pause_widget.dart';

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

  bool isVideoPlaying = false;


  List<String> nameItems = <String>['微信', '朋友圈', 'QQ', 'QQ空间', '微博', '链接'];

  // 这个urlItems这里没有用到
  List<String> urlItems = <String>[
    'images/2.0/wexin_icon.png',
    'images/2.0/friend_icon.png',
    'images/2.0/qq_icon.png',
    'images/2.0/qq_zon_icon.png',
    'images/2.0/weibo_icon.png',
    'images/2.0/link_icon.png',
  ];


  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoModel.videoUrl));
    videoPlayFuture = videoPlayerController.initialize().then((value) {
      ///视频初始化完成之后，调用播放
      videoPlayerController.play();
      isVideoPlaying = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///播放视频
        buildVideWidget(),

        ///播放按钮
        buildPlayButton(),

        ///视频简介
        buildBottomFlagWidget(),

        ///右侧用户信息按钮
        buildRightUserWidget(),
      ],
    );
  }

  buildVideWidget() {
    return FutureBuilder(
        future: videoPlayFuture,
        builder: (context, value) {
          if (value.connectionState == ConnectionState.done) {
            return InkWell(
              onTap: () {
                ///切换视频播放与暂停
                if (videoPlayerController.value.isInitialized) {
                  ///视频已经初始化
                  if (videoPlayerController.value.isPlaying) {
                    videoPause();
                  } else {
                    videoPlay();
                  }
                } else {
                  videoPlayerController.initialize().then((value) {
                    videoPlayerController.play();
                    setState(() {});
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
          } else {
            ///加载动画
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
        });
  }

  buildPlayButton() {
    return Align(
      alignment: Alignment.center,
      child: !isVideoPlaying
          ? InkWell(
              onTap: () {
                videoPlay();
              },
              child: const VideoPauseWidget())
          : Container(),
    );
  }

  videoPlay() {
    if (videoPlayerController.value.isInitialized) {
      ///视频已经初始化
      videoPlayerController.play();
      isVideoPlaying = true;
      setState(() {});
    }
  }

  videoPause() {
    if (videoPlayerController.value.isInitialized) {
      ///视频已经初始化
      videoPlayerController.pause();
      isVideoPlaying = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  buildBottomFlagWidget() {
    return Positioned(
        left: 0,
        right: 64,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: Colors.transparent,
          height: 100,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "@索隆",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "隆江猪脚饭，好吃的不得行",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }

  buildRightUserWidget() {
    return Align(
      alignment: Alignment(1, 0.4),
      child: Container(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///用户信息
            buildUserItem(),

            const SizedBox(
              height: 10,
            ),

            ///点赞
            buildLikeWidget(
                widget.videoModel.isLike
                    ? "images/2.0/like_icon_2.png"
                    : "images/2.0/like_icon.png",
                widget.videoModel.pariseCount,
                () {}),
            const SizedBox(
              height: 10,
            ),

            ///评论
            buildLikeWidget(
                "images/2.0/comment_icon.png", widget.videoModel.pariseCount,
                () {
              showBottomFunction(1);
            }),
            const SizedBox(
              height: 10,
            ),

            ///分享
            buildLikeWidget(
                "images/2.0/transpond_icon.png", widget.videoModel.shareCount,
                () {
              showBottomFunction(2);
            }),
          ],
        ),
      ),
    );
  }

  buildUserItem() {
    return SizedBox(
      width: 45,
      height: 45,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipOval(
              child: Container(
                width: 45,
                height: 45,
                color: Colors.grey,
                child: Image.asset(widget.videoModel.videoImag),
              ),
            ),
          ),
          widget.videoModel.isAttention
              ? Container()
              : Align(
                  alignment: const Alignment(0, 1),
                  child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.add_circle,
                        color: Colors.red,
                        size: 16,
                      )),
                )
        ],
      ),
    );
  }

  buildLikeWidget(String assetImage, int msgCount, callBack) {
    return InkWell(
      onTap: callBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(assetImage, width: 35, height: 35),
          const SizedBox(
            height: 2,
          ),
          Text(
            msgCount.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }

  ///底部弹框
  void showBottomFunction(int i) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          if (i == 1) {
            return commentFunction();
          } else {
            return shareFunction();
          }
        });
  }

  ///评论
  Widget commentFunction() {
    return Container(
      height: 390,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "评论区",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  )),
              Align(
                  alignment: const Alignment(1, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 350,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Image.asset(
                            "images/2.0/wexin_icon.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "乔巴",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "我一定会成为海贼王的哈哈哈哈哈哈哈哈哈哈哈哈！！！！！！",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.black),
                                maxLines: 2,
                              ),
                              Container(

                                margin: const EdgeInsets.only(top: 6),
                                padding: const EdgeInsets.only(left: 6, right: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "6小时前",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }))
        ],
      ),
    );
  }

  Widget shareFunction() {
    return SafeArea(
      child: Container(
        height: 260,
        padding: const EdgeInsets.only(top: 8),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SizedBox(
                height: 190,
                child: GridView.builder(
                  itemCount: nameItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 5,crossAxisSpacing: 1),
                    itemBuilder: (context,index){
      
                      return Column(
                        children: [
                          Image.asset(urlItems[index],width: 40,height: 40,),
                          Text(nameItems[index])
                        ],
                      );
      
                }),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  child: const Text("取消")),
            )
          ],
        ),
      ),
    );
  }
}
