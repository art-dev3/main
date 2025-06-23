import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main/views/home.dart';
import 'package:stac/stac.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Stac.initialize(); // Required by Stac
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stac Credit Card UI',
      home: MyHomePage(title: 'TEST'),
    );
  }
}
