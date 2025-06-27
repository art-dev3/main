import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main/controllers/auth_controller.dart';
import 'package:main/views/json_dynamic_widget/widget/announcement_section.dart';
import 'package:main/views/json_dynamic_widget/widget/da_card.dart';

class DAScreenBuilder {
  static Widget buildWidget(
    Map<String, dynamic> json, {
    required BuildContext context,
  }) {
    switch (json['type']) {
      case 'Scaffold':
        return Scaffold(
          appBar:
              buildWidget(json['appBar'], context: context)
                  as PreferredSizeWidget?,
          body: buildWidget(json['body'], context: context),
        );

      case 'AppBar':
        return AppBar(
          title: buildWidget(json['title'], context: context),
          actions:
              (json['actions'] as List<dynamic>?)
                  ?.map(
                    (a) => buildWidget(
                      a as Map<String, dynamic>,
                      context: context,
                    ),
                  )
                  .toList() ??
              [],
        );

      case 'Text':
        return Text(
          json['value'] ?? '',
          style: TextStyle(
            fontSize: _parseDouble(json['style']?['fontSize']),
            fontWeight: _parseFontWeight(json['style']?['fontWeight']),
          ),
        );

      case 'SingleChildScrollView':
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: _parseDouble(json['padding']?['horizontal']),
            vertical: _parseDouble(json['padding']?['vertical']),
          ),
          child: buildWidget(json['child'], context: context),
        );

      case 'Column':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (json['children'] as List)
              .map(
                (child) => buildWidget(
                  child as Map<String, dynamic>,
                  context: context,
                ),
              )
              .toList(),
        );

      case 'SizedBox':
        return SizedBox(height: _parseDouble(json['height']));

      case 'DaCard':
        return DaCard(
          title: json['title'],
          subtitle: json['subtitle'],
          buttonText: json['buttonText'],
          backGroundImageUrl: json['backGroundImageUrl'],
          overlayImageUrl: json['overlayImageUrl'],
          textColor: _parseColor(json['textColor'])!,
          overlayColor: _parseColor(json['overlayColor'])!,
          overlayImageUrlHeight: _parseDouble(
            json['overlayImageUrlHeight'],
            fallback: 100,
          ).toInt(),
          overlayImageUrlWidth: _parseDouble(
            json['overlayImageUrlWidth'],
            fallback: 100,
          ).toInt(),
          onTap: () {
            if (json['onTap']?['action'] == 'navigate' &&
                json['onTap']['route'] != null) {
              Get.toNamed(json['onTap']['route']);
            }
          },
        );

      case 'AnnouncementSection':
        return AnnouncementSection(
          showCategory: json['props']?['showCategory'] ?? false,
          partnerId: json['props']?['partnerId'] ?? '',
        );

      case 'ReactiveUserCard':
        final controller = Get.find<AuthController>();
        return Obx(() {
          String buttonText = _resolveConditionalText(
            json['builder']?['buttonText'],
            userStatus: controller.userStatus.value,
          );
          final builderJson = Map<String, dynamic>.from(json['builder']);
          builderJson['buttonText'] = buttonText;

          return buildWidget(builderJson, context: context);
        });

      default:
        return const SizedBox.shrink();
    }
  }

  static String _resolveConditionalText(
    dynamic conditionalJson, {
    required String userStatus,
  }) {
    if (conditionalJson is String) return conditionalJson;

    if (conditionalJson is Map && conditionalJson['type'] == 'Conditional') {
      final conditions = conditionalJson['conditions'] as List<dynamic>? ?? [];

      for (var condition in conditions) {
        final conditionStr = condition['if'] as String;
        if (conditionStr == 'userStatus == verified' &&
            userStatus == 'verified') {
          return condition['value'];
        }
        if (conditionStr == 'userStatus == underVerification' &&
            userStatus == 'underVerification') {
          return condition['value'];
        }
      }
      return conditionalJson['default'] ?? '';
    }

    return '';
  }

  static double _parseDouble(dynamic value, {double fallback = 0.0}) {
    if (value == null) return fallback;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? fallback;
    return fallback;
  }

  static FontWeight? _parseFontWeight(String? weight) {
    switch (weight) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      default:
        return null;
    }
  }

  static Color? _parseColor(String? colorHex) {
    if (colorHex == null || colorHex.isEmpty) return null;
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xff')));
    } catch (_) {
      return null;
    }
  }
}
