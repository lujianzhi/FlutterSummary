import 'package:flutter/material.dart';
import 'package:flutter_summary/route_jump/page/a_page.dart';
import 'package:flutter_summary/route_jump/page/b_page.dart';
import 'package:flutter_summary/route_jump/page/c_page.dart';
import 'package:flutter_summary/route_jump/page/d_page.dart';

class RouteJumpPage extends StatelessWidget {
  const RouteJumpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        "a": (context) => const APage(),
        "b": (context) => const BPage(),
        "c": (context) => const CPage(),
      },
      home:
          _RouteJumpPage2(ModalRoute.of(context)?.settings.arguments as String),
    );
  }
}

class _RouteJumpPage2 extends StatefulWidget {
  final String title;

  const _RouteJumpPage2(this.title);

  @override
  State<StatefulWidget> createState() => _RouteJumpPageState();
}

class _RouteJumpPageState extends State<_RouteJumpPage2> {
  String pageValue = "D页面返回的数据为";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              "a",
            ),
            child: const Text("跳转A页面"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              "b",
            ),
            child: const Text("跳转B页面"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              "c",
            ),
            child: const Text("跳转C页面"),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DPage(),
              ),
            ).then(
              (value) {
                pageValue = value["value"];
                setState(() {});
              },
            ),
            child: const Text("跳转D页面"),
          ),
          Text(pageValue),
        ],
      ),
    );
  }
}
