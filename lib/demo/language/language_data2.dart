import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

///应用入口
main() => runApp(InitThemPage());

///本地化语言标识
Locale? _initLocal;
///本地存储工具
SharedPreferences? prefs;
///0 是初始化页面 1是主页面
int indexPage=0;

///初始化页面
class InitThemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InitThemState();
  }
}

class _InitThemState extends State<InitThemPage>{
  ///当State与Context绑定时再加载本地缓存
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    requestLocationData();
  }
  ///加载本地缓存
  void requestLocationData() async {
    if (prefs != null) return;
    ///加载本地配置
    prefs = await SharedPreferences.getInstance();
    ///获取本地保存的语言信息
    String? languageCode = prefs?.getString("_languageCode");
    String? countrCode = prefs?.getString("_countrCode");
    if (languageCode!=null&&languageCode.isNotEmpty) {
      _initLocal = Locale(languageCode, countrCode);
    }
    setState(() {
      indexPage=1;
    });
  }

  @override
  Widget build(BuildContext context) {
  ///默认一个中心加载圆圈效果
  Widget bodyItemWidget = const Center(
    child: SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(),
    ),
  );
  ///加载完本地语言后重新初始化 加载主页面
  if(indexPage==1){
    bodyItemWidget = SelectThemPage();
  }
    return MaterialApp(
      home: Scaffold(
        body:bodyItemWidget,
      ),
      localizationsDelegates: [
        ///初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        ///初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
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
          sysLocale = const Locale('en', 'US');
        }
        _initLocal = sysLocale;
        return _initLocal;
      },

      ///当前区域，如果为null则使用系统区域一般用于语言切换
      ///传入两个参数，语言代码，国家代码
      ///这里强制配制
      locale: _initLocal,
      ///定义当前应用程序所支持的语言环境
      supportedLocales: [
        const Locale('en', 'US'), // English 英文
        const Locale('he', 'IL'), // Hebrew 西班牙
        const Locale('zh', 'CN'), // 中文，
      ],
    );
  }
}

///主页面
class SelectThemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectThemState();
  }
}

class SelectThemState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              prefs?.setString("_languageCode", "en");
              prefs?.setString("_countrCode", "US");
            },
            child: Text("选择英文"),
          ),
          ElevatedButton(
            onPressed: () {
              prefs?.setString("_languageCode", "zh");
              prefs?.setString("_countrCode", "CN");
            },
            child: Text("选择中文"),
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
            child: Text("显示日期"),
          ),
        ],
      ),
    );
  }
}



class RootWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///默认显示首页面
      home: SelectThemPage(),
      localizationsDelegates: [
        ///初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        ///初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
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
          sysLocale = const Locale('en', 'US');
        }
        _initLocal = sysLocale;
        return _initLocal;
      },

      ///当前区域，如果为null则使用系统区域一般用于语言切换
      ///传入两个参数，语言代码，国家代码
      ///这里强制配制
      locale: _initLocal,

      ///定义当前应用程序所支持的语言环境
      supportedLocales: const [
        Locale('en', 'US'), // English 英文
        Locale('he', 'IL'), // Hebrew 西班牙
        Locale('zh', 'CN'), // 中文，
      ],
    );
  }
}

MaterialApp themDataFunction2() {
  Locale? _initLocal = const Locale('zh', 'CN');
  return MaterialApp(
    home: FirstThemPage(),
    localizationsDelegates: [
      ///初始化默认的 Material 组件本地化
      GlobalMaterialLocalizations.delegate,

      ///初始化默认的 通用 Widget 组件本地化
      GlobalWidgetsLocalizations.delegate,
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

    ///当前区域，如果为null则使用系统区域一般用于语言切换
    ///传入两个参数，语言代码，国家代码
    ///这里强制配制
//    locale:_initLocal,

    ///定义当前应用程序所支持的语言环境
    supportedLocales: const [
      Locale('en', 'US'), // English 英文
      Locale('he', 'IL'), // Hebrew 西班牙
      Locale('zh', 'CN'), // 中文，
    ],
  );
}

MaterialApp themDataFunction() {
  return MaterialApp(
    home: FirstThemPage(),
    localizationsDelegates: [
      ///初始化默认的 Material 组件本地化
      GlobalMaterialLocalizations.delegate,

      ///初始化默认的 通用 Widget 组件本地化
      GlobalWidgetsLocalizations.delegate,
    ],

    ///当前区域，如果为null则使用系统区域一般用于语言切换
    ///传入两个参数，语言代码，国家代码
    ///这里配制为中国
    locale: Locale('zh', 'CN'),

    ///定义当前应用程序所支持的语言环境
    supportedLocales: [
      const Locale('en', 'US'), // English 英文
      const Locale('he', 'IL'), // Hebrew 西班牙
      const Locale('zh', 'CN'), // 中文，
    ],
  );
}

class FirstThemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstThemState();
  }
}

class FirstThemState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
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
          child: Text("显示日期"),
        ),
      ),
    );
  }
}
