import 'package:flutter/material.dart';
import 'package:flutter_summary/home/home_item_data.dart';

import '../future/future_test_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "future_test": (context) => FutureTestPage(),
      },
      home: const HomeStates(),
    );
  }
}

class HomeStates extends StatefulWidget {
  const HomeStates({super.key});

  @override
  State<HomeStates> createState() {
    return _HomeStates();
  }
}

class _HomeStates extends State<HomeStates> {
  final listData = <HomeItemData>[
    HomeItemData("单线程模型", "future_test"),
  ];

  void _itemOnPressed(BuildContext context, HomeItemData data) {
    debugPrint("route:${data.route}");
    Navigator.pushNamed(context, data.route, arguments: data.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ian Flutter学习")),
      body: ListView(
        children: listData
            .map(
              (data) => TextButton(
                onPressed: () => _itemOnPressed(context, data),
                child: Text(data.title),
              ),
            )
            .toList(),
      ),
    );
  }
}
