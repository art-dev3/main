import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main/controllers/auth_controller.dart';
import 'package:main/views/da_dynamic_ui/builder/dynamic_ui.dart';

class DepartmentOfAgricultureScreen extends StatefulWidget {
  final String partnerId;
  final Map<String, dynamic> uiJson;

  const DepartmentOfAgricultureScreen({
    super.key,
    required this.partnerId,
    required this.uiJson,
  });

  @override
  State<DepartmentOfAgricultureScreen> createState() =>
      _DepartmentOfAgricultureScreenState();
}

class _DepartmentOfAgricultureScreenState
    extends State<DepartmentOfAgricultureScreen> {
  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller
        .fetchUserStatus(); // Simulate user status load (verified/pending)
  }

  @override
  Widget build(BuildContext context) {
    // Replace {{partnerId}} in JSON
    final resolvedJson = _replacePlaceholders(widget.uiJson, {
      'partnerId': widget.partnerId,
    });

    return DAScreenBuilder.buildWidget(resolvedJson, context: context);
  }

  /// Utility: Replace {{key}} with actual value recursively in the JSON
  Map<String, dynamic> _replacePlaceholders(
    Map<String, dynamic> json,
    Map<String, String> values,
  ) {
    return json.map((key, value) {
      if (value is String) {
        values.forEach((k, v) {
          value = value.replaceAll('{{$k}}', v);
        });
        return MapEntry(key, value);
      } else if (value is Map) {
        return MapEntry(
          key,
          _replacePlaceholders(Map<String, dynamic>.from(value), values),
        );
      } else if (value is List) {
        return MapEntry(
          key,
          value
              .map(
                (item) => item is Map
                    ? _replacePlaceholders(
                        Map<String, dynamic>.from(item),
                        values,
                      )
                    : item,
              )
              .toList(),
        );
      }
      return MapEntry(key, value);
    });
  }
}
