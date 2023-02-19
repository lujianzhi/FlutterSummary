import 'package:flutter/material.dart';
import 'package:flutter_summary/home/home_item_data.dart';
import 'package:flutter_summary/lifecycle/lifecycle_page.dart';
import 'package:flutter_summary/normal_widget/normal_widget_page.dart';
import 'package:flutter_summary/route_jump/route_jump_page.dart';
import 'package:flutter_summary/thread/multi_thread_page.dart';
import 'package:flutter_summary/thread/single_thread_page.dart';

final listData = <HomeItemData>[
  HomeItemData("单线程模型及future", "single_thread", const SingleThreadPage()),
  HomeItemData("多线程", "multi_thread", const MultiThreadPage()),
  HomeItemData("生命周期", "lifecycle_test", const Lifecycle()),
  HomeItemData("常用控件", "normal_widget", const NormalWidgetPage()),
  HomeItemData("路由跳转", "route_jump", const RouteJumpPage()),
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
        listData[0].route: (context) => listData[0].widget,
        listData[1].route: (context) => listData[1].widget,
        listData[2].route: (context) => listData[2].widget,
        listData[3].route: (context) => listData[3].widget,
        listData[4].route: (context) => listData[4].widget,
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
