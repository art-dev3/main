import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for rootBundle
import 'package:dynamic_widget/dynamic_widget.dart';

class DynamicUIScreen extends StatefulWidget {
  const DynamicUIScreen({super.key});

  @override
  State<DynamicUIScreen> createState() => _DynamicUIScreenState();
}

class _DynamicUIScreenState extends State<DynamicUIScreen> {
  Widget? _loadedUI;

  @override
  void initState() {
    super.initState();
    _loadLocalJsonUI();
  }

  Future<void> _loadLocalJsonUI() async {
    try {
      final rawJson = await rootBundle.loadString('lib/views/test.json');

      final cleanedJson = rawJson
          .replaceAllMapped(
            RegExp(r'"0[xX]FF([0-9A-Fa-f]{6})"'),
            (match) => '"#${match[1]}"',
          )
          .replaceAll('"bold"', '"FontWeight.bold"');

      final Map<String, dynamic> decodedMap = json.decode(cleanedJson);

      final widget = await DynamicWidgetBuilder.buildFromMap(
        decodedMap,
        context,
        DefaultClickListener(),
      );

      setState(() {
        _loadedUI = widget;
      });
    } catch (e) {
      print('Error loading local JSON UI: $e');
      setState(() {
        _loadedUI = Text('Error loading layout: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic UI (Local JSON)")),
      body: _loadedUI ?? const Center(child: CircularProgressIndicator()),
    );
  }
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    debugPrint("Clicked: $event");
  }
}
