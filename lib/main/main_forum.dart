import 'package:flutter/material.dart';

/// FileName main_forum
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:30
///
/// @Description 论坛

class MainForumPage extends StatefulWidget {
  const MainForumPage({super.key});

  @override
  State<MainForumPage> createState() => _MainForumPageState();
}

class _MainForumPageState extends State<MainForumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("论坛"),),
    );
  }
}
