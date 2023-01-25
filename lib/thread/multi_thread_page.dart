import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';

class MultiThreadPage extends StatefulWidget {
  const MultiThreadPage({super.key});

  @override
  State<MultiThreadPage> createState() => MultiThreadState();
}

class MultiThreadState extends State<MultiThreadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ModalRoute.of(context)?.settings.arguments as String)),
      body: ConstraintLayout(

      ),
    );
  }
}
