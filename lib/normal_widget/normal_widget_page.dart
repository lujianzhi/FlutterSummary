import 'package:flutter/material.dart';

class NormalWidgetPage extends StatefulWidget {
  const NormalWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => _NormalWidgetState();
}

class _NormalWidgetState extends State<NormalWidgetPage> {
  Widget _expanded() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text("flex 1"),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(color: Colors.orange),
            child: const Text("flex 3"),
          ),
        ),
      ],
    );
  }

  Widget _mainAxisSize() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("MainAxisSize.min"),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Text("MainAxisSize.max"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _container() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.green, width: 0.4),
        color: Colors.red,
      ),
      child: const Text("Container的使用"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context)?.settings.arguments as String),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _container(),
          _mainAxisSize(),
          _expanded(),
        ],
      ),
    );
  }
}
