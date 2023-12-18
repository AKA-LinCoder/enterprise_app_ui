import 'package:flutter/material.dart';
import 'package:my_enterprise_app/main/item/home_item_page.dart';

/// FileName main_home
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:29
///
/// @Description 首页

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin{

  List<String> topTabList = [
    "推荐","动态","flutter","Kotlin","Swift","Java","Python"
  ];

  late TabController tabController;

  List<Widget> bodyPageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: topTabList.length, vsync: this);
    for (int pageIndex = 0; pageIndex < topTabList.length; pageIndex++) {
      bodyPageList.add(HomeItemPage(pageTitle: topTabList[pageIndex], pageIndex: pageIndex));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context,flag){
          return   [
            SliverAppBar(
              ///设置SliverAppBar是否固定
              pinned: true,
              ///随着滑动隐藏标题
              floating: true,
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle_outline_outlined))
              ],
              title: Material(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
                child: Ink(
                  child: InkWell(
                    onTap: (){
                      ///跳转搜索页面
                    },
                    borderRadius: BorderRadius.circular(6),
                    splashColor: Colors.grey,
                    child: const SizedBox(
                      height: 33,
                      // width: 300,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[300],
                      //   borderRadius: BorderRadius.circular(6),
                      // ),
                      child: Row(
                        children: [
                          SizedBox(width: 12,),
                          Icon(Icons.search,size: 18,),
                          SizedBox(width: 6,),
                          Text("搜索",style: TextStyle(fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                ///不写这个会导致第一个标签左侧还有一段空白
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                controller: tabController,
                tabs: topTabList.map((e) => Tab(text: e,)).toList(),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: bodyPageList,
        ),
      ),
    );
  }
}
