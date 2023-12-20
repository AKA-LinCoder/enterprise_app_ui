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

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            buildLoginInputWidget()
          ],
        ),
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
            buildInputWidget(
                iconData: Icons.lock,
                controller: passwordController,
                focusNode: focusNode2,
                nextFocusNode: null,
                hintText: "请输入密码",
                keyboardType: TextInputType.text),
          ],
        ),
      ),
    );
  }

  buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "images/2.0/logo.jpg",
              width: 55,
            )),
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

  ///未输入时文本框的颜色
  Color normalColor = const Color(0x80fafafa);

  ///正在输入时文本框颜色
  Color selectColor = Colors.green;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

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
}
