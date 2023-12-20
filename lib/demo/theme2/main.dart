import 'package:flutter/material.dart';
import 'package:my_enterprise_app/demo/theme2/provide_config.dart';
import 'package:my_enterprise_app/demo/theme2/them_config.dart';
import 'customscroll_demo_page.dart';
import 'package:provider/provider.dart';





void main() => runApp(

    ChangeNotifierProvider(create: (BuildContext context) {
      return ThemConfigModel();
    },
    child: MyApp(),
    )

);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemConfigModel>(context);
    return MaterialApp(
      title: '看看灰色应用',
      theme: themeModel.defaultTheme,
      home: CustomScrollDemoPage(),
    );
  }
}
