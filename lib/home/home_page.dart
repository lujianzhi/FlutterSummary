import 'package:flutter/material.dart';
import 'package:flutter_summary/home/home_item_data.dart';
import 'package:flutter_summary/lifecycle/lifecycle_page.dart';
import 'package:flutter_summary/thread/multi_thread_page.dart';
import 'package:flutter_summary/thread/single_thread_page.dart';

final listData = <HomeItemData>[
  HomeItemData("单线程模型及future", "single_thread"),
  HomeItemData("多线程", "multi_thread"),
  HomeItemData("生命周期", "lifecycle_test"),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        listData[0].route: (context) => const SingleThreadPage(),
        listData[1].route: (context) => const MultiThreadPage(),
        listData[2].route: (context) => const Lifecycle(),
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
