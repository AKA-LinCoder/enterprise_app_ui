import 'package:flutter/material.dart';

/// FileName main_mine
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:29
///
/// @Description 我的

class MainMinePage extends StatefulWidget {
  const MainMinePage({super.key});

  @override
  State<MainMinePage> createState() => _MainMinePageState();
}

class _MainMinePageState extends State<MainMinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的"),),
    );
  }
}
