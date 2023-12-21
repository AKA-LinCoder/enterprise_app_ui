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

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin,WidgetsBindingObserver{
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

  ///logo动画控制器
  late AnimationController logoAnimationController;
  late Animation<double> logoAnimation;



  //输入框动画控制器
  //当输入的手机号不合格或者是密码不合格时
  //通过此动画实现抖动效果
  late AnimationController inputAnimatController;
  late Animation inputAnimaton;

  ///抖动动画执行次数
  int inputAnimationNumber = 0;

  ///输入手机号码合格标识
  /// 11位为合格，此值为false 否则为为true不合格
  bool isPhoneError = false;

  ///输入密码合格标识
  /// 6-12位为合格，此值为false 否则为true不合格
  bool isPasswordError = false;


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

    ///注册动画
    animationController = AnimationController(vsync: this,duration: const Duration(seconds: 4));
    animationController.addListener(() {
      setState(() {

      });
    });
    ///logo动画控制
    logoAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    logoAnimationController.addListener(() {
      setState(() {

      });
    });

    ///动画执行方式
    logoAnimation = Tween(begin: 1.0,end: 0.0).animate(logoAnimationController);

    //添加监听
    WidgetsBinding.instance.addObserver(this);



    ///这里是通过左右摆动两次来实现的抖动动画
    inputAnimatController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    ///构建线性动画，从0-10的匀速
    inputAnimaton =
        new Tween(begin: 0.0, end: 10.0).animate(inputAnimatController);

    ///添加监听，动画执行的每一帧都会回调这里
    inputAnimatController.addListener(() {
      double value = inputAnimatController.value;
      print("变化比率 $value");
      setState(() {});
    });

    ///添加动画执行状态监听
    inputAnimatController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("正向执行完毕 调用 forward方法动画执行完毕的回调");
        inputAnimationNumber++;

        ///反向执行动画
        inputAnimatController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        print("反向执行完毕 调用reverse方法动画执行完毕的回调");

        ///重置动画
        inputAnimatController.reset();

        ///记录动画的执行次数
        ///执行2次便达到了左右抖动的视觉效果
        if (inputAnimationNumber < 2) {
          //正向执行动画
          inputAnimatController.forward();
        } else {
          inputAnimationNumber = 0;
        }
      }
    });
  }

  @override
  void didChangeMetrics() {
    ///通过WidgetsBindingObserver的次方法监听页面布局变化
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    /*
     *Frame是一次绘制过程，称其为一帧，Flutter engine受显示器垂直同步信号"VSync"的驱使不断的触发绘制，
     *Flutter可以实现60fps（Frame Per-Second），就是指一秒钟可以触发60次重绘，FPS值越大，界面就越流畅。
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //注意，不要在此类回调中再触发新的Frame，这可以会导致循环刷新。
      setState(() {

        ///获取底部遮挡区域的高度
        double keyboardFlexHeight = MediaQuery.of(context).viewInsets.bottom;
        print("键盘的高度 keyboardFlexHeight $keyboardFlexHeight");
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘 启动logo动画反向执行 0.0 -1.0
          // logo 布局区域显示出来
          logoAnimationController.reverse();
        } else {
          //显示键盘 启动logo动画正向执行 1.0-0.0
          // logo布局区域缩放隐藏
          logoAnimationController.forward();
        }
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
            ///logoAnimation会从1到0,动态改变顶部距离
            ///顶部距离
            Container(
              margin:  EdgeInsets.only(left: 22, right: 22, top: 100*logoAnimation.value),
            ),

            ///logo
            buildLogo(),
            const SizedBox(
              height: 30,
            ),

            ///输入框
            buildInputWidget(
                iconData: Icons.phone_android_outlined,
                controller: phoneController,
                focusNode: focusNode1,
                nextFocusNode: focusNode2,
                hintText: "请输入手机号",
                isError: isPhoneError,
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
                isError: isPasswordError,
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
    return ScaleTransition(
      ///缩放中心
      alignment: Alignment.center,
      scale: logoAnimation,
      child: Row(
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
      ),
    );
  }

 
  buildInputWidget(
      {required IconData iconData,
      required TextEditingController controller,
      required FocusNode focusNode,
        FocusNode? nextFocusNode,
      String? hintText,
      TextInputAction? textInputAction,
        required bool isError,
        List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType}) {
    return Transform.translate(
      //只有为输入校验错误里才启用左右平移实现抖动提示效果
      offset: Offset(isError ? inputAnimaton.value : 0, 0),
      child: Container(
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
      ),
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
        ///隐藏输入框焦点
        focusNode1.unfocus();
        focusNode2.unfocus();

        ///获取输入的电话号码
        String inputPhone = phoneController.text;
        if (inputPhone.isEmpty) {
          ///更新标识 触发抖动动画
          isPhoneError = true;
          inputAnimatController.forward();
          return;
        } else {
          isPhoneError = false;
        }

        ///获取输入的密码
        String inputPassword = passwordController.text;
        if (inputPassword.isEmpty) {
          ///更新标识 触发抖动动画
          isPasswordError = true;
          inputAnimatController.forward();
          return;
        } else {
          isPasswordError = false;
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



