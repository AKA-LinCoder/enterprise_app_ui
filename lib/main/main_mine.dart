import 'package:flutter/material.dart';
import 'package:my_enterprise_app/base/base_page.dart';
import 'package:my_enterprise_app/login_page.dart';

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

class _MainMinePageState extends BasePage<MainMinePage> {

  bool isLogin = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff4f5f7),
      child: Column(
        children: [
          ///顶部菜单设置栏
          buildHeaderWidget(),
          Expanded(child: buildScrollBodyView())
        ],
      ),
    );
  }

  buildHeaderWidget() {
    //获取状态栏高度
    double topHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 44 + topHeight+14,
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.only(left: 14),
                    height: 44 + topHeight,
                    alignment: Alignment.bottomLeft,
                    color: const Color(0xfff0ebe6),
                    child: Image.asset(
                      "images/2.0/my_add_icon.png",
                      width: 20,
                      height: 20,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(right: 14),
                    height: 44 + topHeight,
                    color: const Color(0xfff0ebe6),
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
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Image.asset(
                            "images/2.0/my_meun_icon.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Container(color: const Color(0xfff0ebe6),height: 14,),
        ],
      ),
    );
  }

  buildScrollBodyView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                color: const Color(0xfff0ebe6),
              ),
              isLogin?buildUserInfo():
              ///用户未登录UI
              buildUnLoginUI(),
            ],
          )

        ],
      ),
    );
  }

  buildUserInfo() {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 16),
                  child: ClipOval(child: Image.asset("images/2.0/logo.jpg",width: 55,height:55,fit: BoxFit.fill,))),
               Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text("用户名",style: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(width: 10,),
                    Image.asset("images/2.0/my_man_icon.png",width: 20,)
                    ],
                  ),
                  Row(
                    children: [
                      const Text("这里是五条吾",style: TextStyle(fontSize: 14,color: Colors.black87),),
                      const SizedBox(width: 10,),
                      Image.asset("images/2.0/my_question_icon.png",width: 15,)
                    ],
                  )
                ],
              ))
            ],
          ),
           SizedBox(height: 15,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Container(

                child: Row(
                  children: [
                    buildCountBody(21,"关注"),
                    buildCountBody(321,"粉丝"),
                    buildCountBody(221,"排名"),
                    buildCountBody(121,"访问"),
                  ],
                ),
              )),
              const Row(
                children: [
                  SizedBox(width: 5,),
                  Text("主页",style: TextStyle(fontSize: 15,color: Colors.black54),),
                  SizedBox(width: 5,),
                  ///小箭头
                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black54),
                  SizedBox(width: 16,),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  buildCountBody(int count,String title){
    return Expanded(child: Column(
      children: [
        Text(count.toString(),style: const TextStyle(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.bold),),
        const SizedBox(height: 6,),
        Text(title,style: const TextStyle(fontSize: 18,color: Colors.black54),)
      ],
    ));
  }

  buildUnLoginUI() {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildIconButton("images/2.0/my_qq_icon.png",onPressed: (){
                print("tap me");
              }),
              buildIconButton("images/2.0/my_phone_icon.png"),
              buildIconButton("images/2.0/my_weixin_icon.png"),
            ],
          ),
          GestureDetector(
            onTap: (){
               pushPage(const LoginPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: const Text("登录 注册",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
          )
        ],
      ),
    );
  }


  buildIconButton(String iconName,{Function()? onPressed}) {
    return  Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            margin: const EdgeInsets.only(bottom: 12,left: 12,right: 20),
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // color: Colors.grey[300],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Image.asset(iconName,width: 22,height: 22,)),
      ),
    );
  }





}
