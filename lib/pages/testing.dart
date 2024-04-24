
import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  TestingPageState createState() => TestingPageState();
}

class TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Pos Plugin Platform example app'),
        ),
        body: const Text('Test'));
  }
}
