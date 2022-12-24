import 'dart:async';

import 'package:flutter/material.dart';

class FutureTestPage extends StatefulWidget {
  FutureTestPage({super.key});

  @override
  State<FutureTestPage> createState() {
    return _FutureTestPageState();
  }
}

class _FutureTestPageState extends State<FutureTestPage> {
  final String _bigTestGif = "assets/img/big_test.gif";
  String _bigTestResult = "等待执行任务";
  bool _bigTestGifShow = false;

  void _updateResult(String result) {
    setState(() {
      _bigTestResult += "$result、";
    });
  }

  void _bigTest() {
    _bigTestResult = "";
    Future(() => _updateResult("f1")); //声明一个匿名Future
    Future fx = Future(() => null); //声明Future fx，其执行体为null

//声明一个匿名Future，并注册了两个then。在第一个then回调里启动了一个微任务
    Future(() => _updateResult("f2")).then((_) {
      _updateResult("f3");
      scheduleMicrotask(() => _updateResult("f4"));
    }).then((_) => _updateResult("f5"));

//声明了一个匿名Future，并注册了两个then。第一个then是一个Future
    Future(() => _updateResult("f6"))
        .then((_) => Future(() => _updateResult("f7")))
        .then((_) => _updateResult("f8"));

//声明了一个匿名Future
    Future(() => _updateResult("f9"));

//往执行体为null的fx注册了了一个then
    fx.then((_) => _updateResult("f10"));

//启动一个微任务
    scheduleMicrotask(() => _updateResult("f11"));
    _updateResult("f12");
    setState(() {
      _bigTestGifShow = true;
    });
  }

  String _futureResult = "等待执行Future任务";
  int _futureTaskNum = 0;

  void _future() {
    Future(() {
      _futureTaskNum = 0;
      setState(() {
        _futureTaskNum++;
        _futureResult = "执行了$_futureTaskNum次";
      });
    }).then((value) {
      setState(() {
        _futureTaskNum++;
        _futureResult += "\n进入then方法体，总共执行了$_futureTaskNum次";
      });
    }).then((value) {
      setState(() {
        _futureTaskNum++;
        _futureResult += "\n进入then方法体，总共执行了$_futureTaskNum次";
      });
    });
  }

  String _microTaskResult = "等待执行微任务";
  int _microTaskNum = 0;

  void _sendMicroTask() {
    scheduleMicrotask(() {
      setState(() {
        _microTaskNum++;
        _microTaskResult = "执行了微任务$_microTaskNum次";
      });
    });
  }

  Widget _bigTestWidget() {
    return Column(
      children: [
        TextButton(onPressed: _bigTest, child: const Text("大测试")),
        Text(_bigTestResult),
        Visibility(
          visible: _bigTestGifShow,
          child: Image.asset(_bigTestGif),
        ),
      ],
    );
  }

  Widget _futureWidget() {
    return Column(
      children: [
        TextButton(onPressed: _future, child: const Text("创建Future")),
        Text(_futureResult),
      ],
    );
  }

  Widget _microTaskWidget() {
    return Column(
      children: [
        TextButton(onPressed: _sendMicroTask, child: const Text("发送微任务")),
        Text(_microTaskResult),
      ],
    );
  }

  Widget _eventLoopWidget() {
    return Column(
      children: <Widget>[
        const Text("EventLoop模型"),
        Image.asset("assets/img/event_loop.webp")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context)?.settings.arguments as String),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _eventLoopWidget(),
            Divider(color: Colors.primaries.first, thickness: 2.0),
            _microTaskWidget(),
            Divider(color: Colors.primaries.first, thickness: 2.0),
            _futureWidget(),
            Divider(color: Colors.primaries.first, thickness: 2.0),
            _bigTestWidget(),
          ],
        ),
      ),
    );
  }
}
