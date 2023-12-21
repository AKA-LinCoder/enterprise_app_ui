import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// FileName login_page
///
/// @Author LinGuanYu
/// @Date 2023/12/20 14:47
///
/// @Description 登录页面

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  ///未输入时文本框的颜色
  Color normalColor = const Color(0x80fafafa);

  ///正在输入时文本框颜色
  Color selectColor = Colors.green;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  ///动画注册器
  late AnimationController animationController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode1.addListener(() {
      setState(() {});
    });

    focusNode2.addListener(() {
      setState(() {});
    });

    animationController = AnimationController(vsync: this,duration: const Duration(seconds: 4));
    animationController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///阻止页面向上挤压
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (){
          ///点击空白处隐藏键盘
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Stack(
          children: [
            ///背景层
            buildBgWidget(),

            ///高斯模糊层
            buildBlurBg(),

            ///用户输入框层
            buildLoginInputWidget(),


          ],
        ),
      ),
    );
  }
  
  
  buildAgreementWidget(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        children: [
          buildCircleCheckBox(),
          const SizedBox(width: 1,),
          Expanded(child: RichText(text: TextSpan(text: "注册同意",style: const TextStyle(fontSize: 15),children: [
            const TextSpan(text: "《用户注册协议》",style: TextStyle(color: Colors.orangeAccent,fontSize: 15)),
            const TextSpan(text: "与",style: TextStyle(fontSize: 15)),
            TextSpan(text: "《隐私协议》",style: const TextStyle(color: Colors.orangeAccent,fontSize: 15),recognizer: TapGestureRecognizer()..onTap = (){
              if (kDebugMode) {
                print("点击了隐私协议00");
              }
            }),
          ]),))
        ],
      ),
    );
  }
  

  ///全屏背景图
  buildBgWidget() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 0,
        child: Image.asset(
          "images/2.0/login_bg.jpeg",
          fit: BoxFit.fill,
        ));
  }

  buildBlurBg() {
    return Container(
      color: const Color.fromARGB(155, 100, 100, 100),
    );
  }

  buildLoginInputWidget() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ///顶部距离
            Container(
              margin: const EdgeInsets.only(left: 22, right: 22, top: 100),
            ),

            ///logo
            buildLogo(),
            SizedBox(
              height: 30,
            ),

            ///输入框
            buildInputWidget(
                iconData: Icons.phone_android_outlined,
                controller: phoneController,
                focusNode: focusNode1,
                nextFocusNode: focusNode2,
                hintText: "请输入手机号",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11)
                  // FilteringTextInputFormatter.a
                ],
                keyboardType: TextInputType.number),
            const SizedBox(height: 30,),
            buildInputWidget(
                iconData: Icons.lock,
                controller: passwordController,
                focusNode: focusNode2,
                nextFocusNode: null,
                hintText: "请输入密码",
                keyboardType: TextInputType.text),
            const SizedBox(height: 30,),
            ///用户协议层
            buildAgreementWidget(),
            const SizedBox(height: 30,),
            ///注册按钮
            buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            ///启动动画控制器
            animationController.forward();

            // setState(() {
            //   isRegistering = !isRegistering;
            // });
            Future.delayed(const Duration(milliseconds: 8000), (){
              animationController.reverse();
            });
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "images/2.0/logo.jpg",
                width: 55,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          "Echo",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

 
  buildInputWidget(
      {required IconData iconData,
      required TextEditingController controller,
      required FocusNode focusNode,
        FocusNode? nextFocusNode,
      String? hintText,
      TextInputAction? textInputAction,
        List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType}) {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border:
              Border.all(color: focusNode.hasFocus ? selectColor : normalColor),
          color: const Color(0x50fafafa)),
      // height: 20,
      child: buildInputItemRow(
          iconData: iconData,
          controller: controller,
          focusNode: focusNode,
          hintText: hintText,
          textInputAction: textInputAction,
          inputFormatters:inputFormatters,
          keyboardType: keyboardType,nextFocusNode: nextFocusNode),
    );
  }

  buildInputItemRow(
      {required IconData iconData,
      required TextEditingController controller,
      required FocusNode focusNode,
        FocusNode? nextFocusNode,
      String? hintText,
      TextInputAction? textInputAction,
        List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType}) {
    return Row(
      children: [
        ///左侧图
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              iconData,
              color: const Color(0xaafafafa),
              size: 26,
            )),

        ///竖线
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 1,
            height: 26,
            color: const Color(0xaafafafa),
          ),
        ),

        ///输入框
        Expanded(
            child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          focusNode: focusNode,

          ///键盘回车按钮监听
          onSubmitted: (value) {
            focusNode.unfocus();
            if(nextFocusNode!=null){
              FocusScope.of(context).requestFocus(nextFocusNode);
            }

          },
          textInputAction: textInputAction,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          inputFormatters: inputFormatters,
          // keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        )),

        ///清除按钮
        focusNode.hasFocus
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    ///清除输入框内容
                    controller.clear();
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 26,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  bool checkIsSelect = false;

  buildCircleCheckBox() {
    return Checkbox(
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: checkIsSelect,
        onChanged: (value){
          setState(() {
            checkIsSelect = ! checkIsSelect;
          });
        },
        checkColor: Colors.white, //修改勾选时的勾选颜色为红色
        activeColor: Colors.orange, //去掉勾选时背景颜色
        side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            //修改勾选时边框颜色为红色
            return const BorderSide(width: 2, color: Colors.orange);
          }
          //修改默认时边框颜色为绿色
          return const BorderSide(width: 2, color: Colors.white);
        },
        ));
  }

  bool isRegistering = false;

  buildRegisterButton() {
    return InkWell(

      onTap: (){
        if (kDebugMode) {
          print("我使劲点开");
        }
        ///启动动画控制器
        animationController.forward();

        // setState(() {
        //   isRegistering = !isRegistering;
        // });
        Future.delayed(const Duration(milliseconds: 8000), (){
          ///模拟失败
          currentRequestStatus = RequestStatus.error;
          setState(() {

          });
          Future.delayed(const Duration(milliseconds: 2000), (){
            animationController.reverse();
          });

        });
      },

      child: Stack(
        children: [

          Transform(
            alignment: Alignment.center,
            ///x,y,z缩放比
            transform: Matrix4.diagonal3Values(1.0-animationController.value, 1.0, 1.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: const Color(0x50fafafa),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.red)
              ),
              child: const Text("注册",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
            ),
          ),
          ///进度圆圈
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: animationController.value,
                child: Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0x50fafafa),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  ///根据不同状态修改不同的中间显示
                  child: buildLoadingWidget(),
                ),
              )
            ],
          )

        ],
      ),
    );
  }

  RequestStatus currentRequestStatus = RequestStatus.none;

  ///动态构建不同的显示进度圆圈
  /// 加载中、加载错误、加载成功
  Widget buildLoadingWidget() {
    ///默认使用加载中
    Widget loadingWidget = const CircularProgressIndicator();
    if (currentRequestStatus == RequestStatus.success) {
      ///加载成功显示小对钩
      loadingWidget = const Icon(
        Icons.check,
        color: Colors.deepOrangeAccent,
      );
    } else if (currentRequestStatus == RequestStatus.error) {
      ///加载失败状态显示 小X
      loadingWidget = const Icon(
        Icons.close,
        color: Colors.red,
      );
    }
    return loadingWidget;
  }
}

enum RequestStatus {
  none, //无状态
  loading, //加载中
  success, //加载成功
  error, //加载失败
  retry, //重试
}



