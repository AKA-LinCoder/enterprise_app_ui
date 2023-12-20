import 'package:flutter/material.dart';
import 'package:my_enterprise_app/demo/theme/provide_config.dart';
import 'package:my_enterprise_app/demo/theme/them_config.dart';
import 'package:provider/provider.dart';

///flutter 程序的入口函数
///执行runApp 方法 为应用程序创建了一个 root 根布局
void main() => runApp(

    ChangeNotifierProvider(
      create: (context) =>ThemConfigModel(),
      child: const MyThemApp(),
    )
);

class MyThemApp extends StatelessWidget {
  const MyThemApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemConfigModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeModel.defaultTheme,
      home: const MyHomePage(title: 'hahahha',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    final themeModel = Provider.of<ThemConfigModel>(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text("应用主题切换",style: TextStyle(color: themeModel.isDarkMode?Colors.redAccent:Colors.blue),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("亮色"),
              onPressed: () {
                print("点击了亮色");
                themeModel.setThem(0);
                themeModel.toggleTheme();
              },
            ),
            ElevatedButton(
              child: const Text("暗色"),
              onPressed: () {
                print("点击了暗色");
                themeModel.setThem(1);
              },
            ),
            ElevatedButton(
              child: const Text("紫色"),
              onPressed: () {
                print("点击了紫色");
                themeModel.setThem(2);

              },
            ),
          ],
        ),
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ThemeModel extends ChangeNotifier {
//   bool _isDarkMode = false;
//
//   bool get isDarkMode => _isDarkMode;
//
//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }
//
//
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeModel(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Theme Switcher',
//       home: MyHomePage(),
//     );
//   }
// }
//
//
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeModel = Provider.of<ThemeModel>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Theme Switcher'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to the App!',
//           style: TextStyle(
//             color: themeModel.isDarkMode ? Colors.red : Colors.black,
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           themeModel.toggleTheme();
//         },
//         child: Icon(Icons.lightbulb_outline),
//       ),
//     );
//   }
// }
