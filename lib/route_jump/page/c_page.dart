import 'package:flutter/material.dart';

class CPage extends StatefulWidget {
  const CPage({super.key});

  @override
  State<StatefulWidget> createState() => _CPageState();
}

class _CPageState extends State<CPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C"),
      ),
      body: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "b",
            ModalRoute.withName("/"),
          );
        },
        child: const Text("C"),
      ),
    );
  }
}
