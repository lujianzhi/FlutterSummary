import 'package:flutter/material.dart';

class DPage extends StatefulWidget {
  const DPage({super.key});

  @override
  State<StatefulWidget> createState() => _DPageState();
}

class _DPageState extends State<DPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("D"),
      ),
      body: TextButton(
        onPressed: () => Navigator.of(context).pop({"value": "我是来自D页面的数据"}),
        child: const Text("返回页面"),
      ),
    );
  }
}
