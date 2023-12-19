import 'package:flutter/material.dart';

/// FileName video_pause_widget
///
/// @Author LinGuanYu
/// @Date 2023/12/19 11:51
///
/// @Description 视频播放暂停组件

class VideoPauseWidget extends StatelessWidget {
  const VideoPauseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(22)
      ),
      child: const Icon(Icons.play_arrow,color: Colors.black,),
    );
  }
}
