import 'package:flutter/material.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      ///应用程序默认显示页面
      home: IndexPage(),
    );
  }
}
