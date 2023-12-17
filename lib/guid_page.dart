import 'package:flutter/material.dart';
import 'package:my_enterprise_app/base/base_page.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:my_enterprise_app/home_page.dart';

/// FileName guid_page
///
/// @Author LinGuanYu
/// @Date 2023/12/17 15:31
///
/// @Description 引导页

class GuidPage extends StatefulWidget {
  const GuidPage({super.key});

  @override
  State<GuidPage> createState() => _GuidPageState();
}

class _GuidPageState extends BasePage<GuidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        itemCount: 2,
        autoplay: true,
        controller: SwiperController(),

        ///小原点
        pagination: const SwiperPagination(),
        itemBuilder: (context, index) {
          if (index == 1) {
            return Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      "images/2.0/s0${index + 1}.jpeg",
                      fit: BoxFit.cover,
                    )),
                const Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 200,),
                        Text("山高水长",style: TextStyle(color: Colors.white,fontSize: 22),),SizedBox(height: 22,),
                        Text("echo",style: TextStyle(color: Colors.white))],
                    )),
                Positioned(
                    bottom: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text("进入首页"),
                        onPressed: () {
                          pushReplacePage(const HomePage());
                        },
                      ),
                    ))
              ],
            );
          }
          return Image.asset(
            "images/2.0/s0${index + 1}.jpeg",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
