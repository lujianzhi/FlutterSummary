import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summary/thread/transform_data.dart';

class MultiThreadPage extends StatefulWidget {
  const MultiThreadPage({super.key});

  @override
  State<MultiThreadPage> createState() => MultiThreadState();
}

class MultiThreadState extends State<MultiThreadPage> {
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
  ReceivePort? port;

  _startIsolate() async {
    port = ReceivePort();

    isolate = await Isolate.spawn(_handleIsolate, port!.sendPort);

    port!.listen((message) {
      debugPrint("listen : ${Isolate.current.debugName}");
      TransformData data = message as TransformData;
      _isolateDefault = data.toString();
      setState(() {});
    });
  }

  /// 需要是top-level的方法，或者static修饰的方法
  static _handleIsolate(SendPort? sendPort) {
    debugPrint("_handleIsolate : ${Isolate.current.debugName}");
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
        children: [_buildIsolateWidget(), _buildComputeWidget()],
      ),
    );
  }

  @override
  void dispose() {
    _killIsolate();
    super.dispose();
  }
}
