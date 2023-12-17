import 'package:flutter/material.dart';

/// FileName main_discovery
///
/// @Author LinGuanYu
/// @Date 2023/12/17 16:29
///
/// @Description 发现

class MainDiscoveryPage extends StatefulWidget {
  const MainDiscoveryPage({super.key});

  @override
  State<MainDiscoveryPage> createState() => _MainDiscoveryPageState();
}

class _MainDiscoveryPageState extends State<MainDiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("发现"),),
    );
  }
}
