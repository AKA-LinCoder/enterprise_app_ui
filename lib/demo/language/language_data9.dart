///2.9.4应用内切换语言环境然后动态更新语言当前语言环境
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_config.dart';

///应用入口
main() => runApp(InitThemPage(key: langGlobalKey));

///本地化语言标识
Locale? _initLocal;

///本地存储工具
SharedPreferences? prefs;

///0 是初始化页面 1是主页面
int indexPage = 0;

///Widget的标识GloalKey 
GlobalKey<_InitThemState> langGlobalKey = new GlobalKey();

///初始化页面
class InitThemPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _InitThemState();
  }

  InitThemPage({Key? key}) : super(key: key);
}

class _InitThemState extends State<InitThemPage> {
  ///当State与Context绑定时再加载本地缓存
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///加载本地缓存
    requestLocationData();
  }

  ///定义外部修改语言环境的方法 
  changeLocale(Locale locale) {
    setState(() {
      _initLocal = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///默认一个中心加载圆圈效果
    Widget bodyItemWidget = Center(
      child: SizedBox(
        width: 40,
        height: 40,

        ///圆圈组件
        child: CircularProgressIndicator(),
      ),
    );

    ///加载完本地语言后重新初始化 加载主页面
    if (indexPage == 1) {
      bodyItemWidget = SelectThemPage();
    }
    return MaterialApp(
      home: Scaffold(
        body: bodyItemWidget,
      ),
      ///2.9.5  配置自定义语言配置代理
      localizationsDelegates: [
        ///初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        ///初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
        ///自定义的语言配制文件代理 初始化
        MyLocationsLanguageDelegates.delegate,
      ],
      localeResolutionCallback:
          (Locale? sysLocale, Iterable<Locale> supportedLocales) {
        ///locale 反回当前系统的语言环境
        ///supportedLocales 返回 supportedLocales 中配制的语言环境支持的配置
        ///判断应用程序是否支持当前系统语言
        List<String> locals = [];
        List<Locale> list = supportedLocales.toList();
        for (int i = 0; i < list.length; i++) {
          locals.add(list[i].languageCode);
        }

        ///如果当前系统的语言应用程序不支持
        ///那么在这里默认返回英文环境
        if (!locals.contains(sysLocale?.languageCode)) {
          sysLocale = Locale('en', 'US');
        }
        _initLocal = sysLocale;
        return _initLocal;
      },

      ///配置程序语言环境
      locale: _initLocal,

      ///定义当前应用程序所支持的语言环境
      supportedLocales: [
        const Locale('en', 'US'), // English 英文
        const Locale('zh', 'CN'), // 中文，
      ],
    );
  }

  ///加载本地缓存
  void requestLocationData() async {
    if (prefs != null) return;

    ///加载本地配置
    prefs = await SharedPreferences.getInstance();

    ///获取本地保存的语言信息
    String? _languageCode = prefs?.getString("_languageCode");
    String? _countrCode = prefs?.getString("_countrCode");
    if (_languageCode != null && _languageCode.isNotEmpty) {
      _initLocal = Locale(_languageCode, _countrCode);
    }

    ///更新页面
    setState(() {
      indexPage = 1;
    });
  }
}

///主页面
class SelectThemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectThemState();
  }
}

///2.9.5  配置自定义语言配置代理 引用配置的多语言环境文字
class SelectThemState extends State<SelectThemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///Column 子Widget竖直方向线性排列
      body: Column(

        ///子Widget居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              ///保存本地配置信息
              prefs?.setString("_languageCode", "en");
              prefs?.setString("_countrCode", "US");
              ///切换应用内语言环境
              langGlobalKey.currentState?.changeLocale(Locale('en', 'US'));
            },
            ///引用MyLocationsLanguages中配置的国际化语言支持
            child:  Text(MyLocationsLanguages.of(context).selectEnlish),
          ),
          ElevatedButton(
            onPressed: () {
              prefs?.setString("_languageCode", "zh");
              prefs?.setString("_countrCode", "CN");
              langGlobalKey.currentState?.changeLocale(Locale('zh', 'CN'));
            },
            child: Text(MyLocationsLanguages.of(context).selectChinese),
          ),
          ElevatedButton(
            onPressed: () {
              ///显示日期组件
              showDatePicker(
                  context: context,
                  ///初始日期设置为现在
                  initialDate: new DateTime.now(),
                  firstDate:
                  new DateTime.now().subtract(new Duration(days: 30)),
                  lastDate: new DateTime.now().add(new Duration(days: 30)))
                  .then((v) {});
            },
            child: Text(MyLocationsLanguages.of(context).selectShowDate),
          ),
        ],
      ),
    );
  }
}
