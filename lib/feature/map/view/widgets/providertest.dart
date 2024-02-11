import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => WidgetSwitcher(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Display Example'),
      ),
      body: Consumer<WidgetSwitcher>(
        builder: (context, widgetSwitcher, _) {
          return Container(
            child: widgetSwitcher.currentWidget,
          );
        },
      ),
    );
  }
}

class WidgetSwitcher extends ChangeNotifier {
  late Widget _currentWidget;

  WidgetSwitcher() {
    _currentWidget = Widget1(onPressed: switchToWidget2);
  }

  Widget get currentWidget => _currentWidget;

  void switchToWidget2() {
    _currentWidget = Widget2();
    notifyListeners();
  }
}

class Widget1 extends StatelessWidget {
  final VoidCallback onPressed;

  Widget1({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Call the onPressed callback provided by the parent
          onPressed();
        },
        child: Text('Press Me in Widget1'),
      ),
    );
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Widget2 Displayed!'),
    );
  }
}
