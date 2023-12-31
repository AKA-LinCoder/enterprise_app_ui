
///2.9.1 配置日期组件显示为中文 MaterialApp配置中文语言环境设置
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///应用入口 
main() => runApp(themDataFunction());

MaterialApp themDataFunction() {
  return MaterialApp(home: FirstThemPage(),
    localizationsDelegates: [

      ///初始化默认的 Material 组件本地化 
      GlobalMaterialLocalizations.delegate,
      //初始化默认的 通用 Widget 组件本地化 
      GlobalWidgetsLocalizations.delegate,
    ],

    ///当前区域，如果为null则使用系统区域一般用于语言切换 
    ///传入两个参数，语言代码，国家代码 
    ///这里配制为中国 
    locale: Locale('zh', 'CN'),

    ///定义当前应用程序所支持的语言环境 
    supportedLocales: [
      const Locale('en', 'US'),// English 英文 
      const Locale('de', 'DE'), // 德语 
      const Locale('zh', 'CN'), // 中文，
    ],);
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
    return Scaffold(body: Center(child: ElevatedButton(onPressed: () {
      ///显示日期组件 
      showDatePicker(context: context,
          //初始日期设置为现在 
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().subtract(new Duration(days: 30)),
          lastDate: new DateTime.now().add(new Duration(days: 30))).then((
          v) {});
    },
      child: Text("显示日期"),),),);
  }
}