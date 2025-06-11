import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ar_plugin/ar_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _arPlugin = ArPlugin();

  //Function to call showArScreen
  void _launchAR() async {
    try {
      await _arPlugin.showArScreen(
        'Shell_Chair.usdz',
        scale: 0.001,
      );
    } catch (e) {
      print('Error launching AR screen: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _launchAR,
                  child: const Text('Launch AR Model'),
                ),
              ],
            ),
          ),

        ),
    );
  }
}
