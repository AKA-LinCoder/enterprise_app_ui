import 'package:flutter/material.dart';

/// FileName main_mine
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:29
///
/// @Description 我的

class MainMinePage extends StatefulWidget {
  const MainMinePage({super.key});

  @override
  State<MainMinePage> createState() => _MainMinePageState();
}

class _MainMinePageState extends State<MainMinePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///顶部菜单设置栏
        buildHeaderWidget()
      ],
    );
  }

  buildHeaderWidget() {
    //获取状态栏高度
    double topHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: 44 + topHeight,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(

        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              flex: 4,
              child: Container(
                height: 44 + topHeight,
                alignment: Alignment.bottomLeft,
                color: const Color(0x0ff0ebe6),
                child: Image.asset(
                  "images/2.0/my_add_icon.png",
                  width: 20,
                  height: 20,
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                height: 44 + topHeight,
                color: const Color(0x0ff0ebe6),
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 44,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: const Center(child: Text("签到",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                    ),
                    const SizedBox(width: 16 ,),
                    Image.asset(
                      "images/2.0/my_setting_icon.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 16 ,),
                    Image.asset(
                      "images/2.0/my_meun_icon.png",
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
