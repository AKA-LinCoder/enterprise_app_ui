import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ///来构建
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      ///应用程序默认显示页面
      home: IndexPage(),
      localizationsDelegates: [
        ///初始化默认的Material组件本地化
        GlobalMaterialLocalizations.delegate,
        ///初始化默认的通用Widget组件本地化
        GlobalWidgetsLocalizations.delegate,
        ///IOS风格本地化
        GlobalCupertinoLocalizations.delegate,
        ///下拉刷新本地化
        RefreshLocalizations.delegate
      ],
      locale: Locale('zh','CN'),
      supportedLocales: [
        Locale('en','US'),
        Locale('zh','CN'),
        Locale('he','IL')
      ],

    );
  }
}
