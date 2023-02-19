import 'package:flutter/material.dart';

class APage extends StatefulWidget {
  const APage({super.key});

  @override
  State<StatefulWidget> createState() => _APageState();
}

class _APageState extends State<APage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "b"),
            child: const Text("跳转B页面"),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "b"),
            child: const Text("跳转B页面并替换当前页面"),
          ),
        ],
      ),
    );
  }
}
