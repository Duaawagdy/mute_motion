import 'package:flutter/material.dart';
import 'package:mute_motion/feature/finishrequest/finishrequest_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompleteOrderPage(),
    );
  }
}

class CompleteOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Order'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ApiService().completeOrder(context);
          },
          child: Text('Complete Order'),
        ),
      ),
    );
  }
}
