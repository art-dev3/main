import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:main/views/json_dynamic_widget/builder/empty_model.dart';
import 'package:main/views/json_dynamic_widget/widget/da_card.dart';

class DaCardBuilder extends JsonWidgetBuilder {
  const DaCardBuilder(this.args) : super(args: args);

  static const String builderType = 'da_card';
  final Map<String, dynamic> args;

  static DaCardBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) {
    return DaCardBuilder(Map<String, dynamic>.from(map['args'] ?? {}));
  }

  @override
  String get type => builderType;

  @override
  Widget buildCustom({
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
    Widget Function(BuildContext, Widget)? childBuilder,
  }) {
    final cardData = data.jsonWidgetArgs['data'] as Map<String, dynamic>? ?? {};

    return DaCard(
      title: cardData['title'] ?? "",
      subtitle: cardData['subtitle'] ?? '',
      buttonText: cardData['buttonText'] ?? 'Click',
      textColor: _parseColor(cardData['textColor']) ?? Colors.white,
      overlayColor:
          _parseColor(cardData['overlayColor']) ?? const Color(0xCC9F0712),
      backGroundImageUrl: cardData['backGroundImageUrl'],
      overlayImageUrl: cardData['overlayImageUrl'] ?? '',
      overlayImageUrlHeight: cardData['overlayImageUrlHeight'] ?? 171,
      overlayImageUrlWidth: cardData['overlayImageUrlWidth'] ?? 179,
    );
  }

  @override
  JsonWidgetBuilderModel createModel({
    required JsonWidgetData data,
    Widget Function(BuildContext, Widget)? childBuilder,
  }) {
    return EmptyModel(args);
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;
    final hex = colorString.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
