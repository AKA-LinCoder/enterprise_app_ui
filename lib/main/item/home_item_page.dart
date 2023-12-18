import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

/// FileName home_item_page
///
/// @Author LinGuanYu
/// @Date 2023/12/18 08:54
///
/// @Description

class HomeItemPage extends StatefulWidget {
  final num pageIndex;
  final String pageTitle;

  const HomeItemPage(
      {super.key, required this.pageTitle, required this.pageIndex});

  @override
  State<HomeItemPage> createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {
  List<String> imageList = [
    "https://up.deskcity.org/pic_source/4e/9e/fb/4e9efbb5ac31ad11673fdf8c55e3a6cf.jpg",
    "https://i1.hdslb.com/bfs/archive/2f2f90eafc3877fe335ec27bf763c1ed69d339f5.jpg",
    "https://img2.baidu.com/it/u=625894305,2200048696&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
    "https://i1.hdslb.com/bfs/archive/f8a26868172c149599bd7898562598a756e4af00.jpg",
    "https://i2.hdslb.com/bfs/archive/ce35dd7944d9fa8eea947335816719069fd21bfa.jpg",
  ];

  num bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 100,
        itemBuilder: (context, index) {
          if (index == 0) {
            Widget bannerWidget = buildBannerFunction();
            return bannerWidget;
          } else {
            return Container(
              height: 100,
              margin: const EdgeInsets.only(top: 10),
              color: Colors.deepOrange,
            );
          }
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
              onIndexChanged: (index){
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