import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';
import 'package:main/services/base/dio_client.dart';
import 'package:main/views/json_dynamic_widget/builder/announcement_builder.dart';
import 'package:main/views/json_dynamic_widget/builder/da_builder.dart';
import '../../services/json_service.dart';

class DaScreen extends StatefulWidget {
  const DaScreen({super.key});

  @override
  State<DaScreen> createState() => DaScreenState();
}

class DaScreenState extends State<DaScreen> {
  JsonWidgetData? _widgetData;

  @override
  void initState() {
    super.initState();
    _loadJsonUI();
  }

  Future<void> _loadJsonUI() async {
    final registry = JsonWidgetRegistry.instance;

    registry.registerCustomBuilder(
      DaCardBuilder.builderType,
      JsonWidgetBuilderContainer(builder: DaCardBuilder.fromDynamic),
    );

    // final response = await DioClient().get('/your-endpoint');
    // registry.setValue('announcements', response.data);
    // registry.setValue('partnerId', 'cphFeoffLex9pJnhe1Gd');

    registry.registerCustomBuilder(
      AnnouncementSectionBuilder.builderType,
      JsonWidgetBuilderContainer(
        builder: AnnouncementSectionBuilder.fromDynamic,
      ),
    );

    registry.registerFunction('say_hello', ({
      required List<dynamic>? args,
      required JsonWidgetRegistry registry,
    }) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hello from server-driven UI!')),
      );
      return null;
    });

    try {
      final json = await JsonService.fetchJson();
      final widgetData = JsonWidgetData.fromDynamic(json, registry: registry);

      setState(() {
        _widgetData = widgetData;
      });
    } catch (e) {
      print('Error loading JSON UI: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetData != null
          ? _widgetData!.build(context: context)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
