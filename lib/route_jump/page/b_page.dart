import 'package:flutter/material.dart';

class BPage extends StatefulWidget {
  const BPage({super.key});

  @override
  State<StatefulWidget> createState() => _BPageState();
}

class _BPageState extends State<BPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B"),
      ),
      body: TextButton(
        onPressed: () => Navigator.pushNamed(context, "c"),
        child: const Text("C"),
      ),
    );
  }
}
