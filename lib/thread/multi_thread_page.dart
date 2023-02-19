import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summary/thread/transform_data.dart';

class MultiThreadPage extends StatefulWidget {
  const MultiThreadPage({super.key});

  @override
  State<MultiThreadPage> createState() => _MultiThreadState();
}

class _MultiThreadState extends State<MultiThreadPage> {
  _startIsolateV3() {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(entryPoint, receivePort.sendPort);
    receivePort.listen((message) {
      if (message is SendPort) {
        debugPrint("main接收到子isolate的发送器了,${Isolate.current.debugName}");
        message.send("main给子isolate发送的消息");
      } else {
        debugPrint("$message,${Isolate.current.debugName}");
      }
    });
  }

  static entryPoint(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) {
      debugPrint("子isolate接收到main的消息了：$message,${Isolate.current.debugName}");
      sendPort.send("子isolate里面给main发的消息");
    });
    sendPort.send(receivePort.sendPort);
  }

  Widget _buildIsolateWidgetV3() {
    return Column(
      children: [TextButton(onPressed: _startIsolateV3, child: const Text("Isolate双向通信")), const Text("双向通信看logcat")],
    );
  }

  List<TransformData> transformDataList = List<TransformData>.empty();

  _startIsolateV2() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn((sendPort) {
      sendPort.send("length ${transformDataList.length}");
    }, receivePort.sendPort);
    receivePort.listen((message) {
      debugPrint("message $message");
    });
  }

  Widget _buildIsolateWidgetV2() {
    return Column(
      children: [TextButton(onPressed: _startIsolateV2, child: const Text("直接跨线程通信")), const Text("会报错")],
    );
  }

  String _computeDefault = "compute";

  _testCompute() async {
    _computeDefault = await compute(_computeData, "ian");
    setState(() {});
  }

  static String _computeData(String data) {
    return "name:$data";
  }

  Widget _buildComputeWidget() {
    return Column(
      children: [TextButton(onPressed: _testCompute, child: const Text("compute")), Text(_computeDefault)],
    );
  }

  String _isolateDefault = "等待线程间通信";

  Isolate? isolate;

  _startIsolate() async {
    ReceivePort port = ReceivePort();

    isolate = await Isolate.spawn(_handleIsolate, port.sendPort);

    port.listen((message) {
      debugPrint("listen : ${Isolate.current.debugName}");
      if (message is List<TransformData>) {
        debugPrint("message $message");
      } else if (message is TransformData) {
        _isolateDefault = message.toString();
        setState(() {});
      }
    });
  }

  static List<TransformData> getList() {
    debugPrint("静态方法里随便打印点什么: ${Isolate.current.debugName}");
    List<TransformData> transformDataList = [];
    transformDataList.add(TransformData("ian1", "123"));
    transformDataList.add(TransformData("ian2", "456"));
    transformDataList.add(TransformData("ian3", "789"));
    return transformDataList;
  }

  /// 需要是top-level的方法，或者static修饰的方法
  static _handleIsolate(SendPort? sendPort) {
    debugPrint("_handleIsolate : ${Isolate.current.debugName}");
    sendPort?.send(getList());
    Timer.periodic(const Duration(seconds: 2), (timer) {
      debugPrint("发送 - ${Isolate.current.debugName}");
      TransformData data = TransformData("ian", DateTime.now().toString());
      sendPort?.send(data);
    });
  }

  _killIsolate() {
    isolate?.kill();
    _isolateDefault = "停止";
    setState(() {});
  }

  Capability? capability;

  _pauseIsolate() {
    capability = isolate?.pause();
    _isolateDefault = "暂停 - capability:${capability.hashCode}";
    setState(() {});
  }

  _resumeIsolate() {
    if (capability == null) {
      return;
    }
    isolate?.resume(capability!);
    _isolateDefault = "继续 - capability:${capability.hashCode}";
    setState(() {});
  }

  Widget _buildIsolateWidget() {
    return Column(
      children: [
        Row(
          children: [
            TextButton(onPressed: _startIsolate, child: const Text("开启Isolate")),
            TextButton(onPressed: _killIsolate, child: const Text("关闭Isolate")),
            TextButton(onPressed: _pauseIsolate, child: const Text("暂停Isolate")),
            TextButton(onPressed: _resumeIsolate, child: const Text("继续Isolate")),
          ],
        ),
        Text(_isolateDefault),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ModalRoute.of(context)?.settings.arguments as String)),
      body: Column(
        children: [
          _buildIsolateWidget(),
          Divider(color: Colors.primaries.first, thickness: 2.0),
          _buildIsolateWidgetV3(),
          Divider(color: Colors.primaries.first, thickness: 2.0),
          _buildIsolateWidgetV2(),
          Divider(color: Colors.primaries.first, thickness: 2.0),
          _buildComputeWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _killIsolate();
    super.dispose();
  }
}
