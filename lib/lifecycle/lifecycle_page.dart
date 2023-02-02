import 'package:flutter/material.dart';

class Lifecycle extends StatefulWidget {
  const Lifecycle({super.key});

  @override
  State<StatefulWidget> createState() => LifecycleState();
}

class LifecycleState extends State<Lifecycle> {
  String _initText = "初始化页面的生命周期调用：\n";
  String _setStateText = "setState后的生命周期调用：\n";

  bool _show = false;

  String _initTextOnce = "";

  _appendText(String content) {
    _initText += "$content -> \n";
    _setStateText += "$content -> \n";
    debugPrint(content);
  }

  _showStateText() {
    _show = true;
    _refresh();
  }

  _refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _appendText("initState()");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appendText("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(covariant Lifecycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _appendText("didUpdateWidget(covariant Lifecycle oldWidget)");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _appendText("setState(VoidCallback fn)");
  }

  @override
  void deactivate() {
    super.deactivate();
    _appendText("deactivate()");
  }

  @override
  void dispose() {
    super.dispose();
    _appendText("dispose()");
  }

  @override
  Widget build(BuildContext context) {
    _appendText("build(BuildContext context)");
    if (_initTextOnce.isEmpty) {
      _initTextOnce = _initText;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context)?.settings.arguments as String),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_initTextOnce),
            TextButton(
                onPressed: _showStateText,
                child: Text(_show ? _setStateText : "点击展示setState后的生命周期调用")),
          ],
        ),
      ),
    );
  }
}
