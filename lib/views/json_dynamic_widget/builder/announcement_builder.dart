import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:main/views/json_dynamic_widget/builder/empty_model.dart';
import 'package:main/views/json_dynamic_widget/widget/announcement_section.dart';

class AnnouncementSectionBuilder extends JsonWidgetBuilder {
  const AnnouncementSectionBuilder(this.args) : super(args: args);

  static const String builderType = 'announcement_section';

  final Map<String, dynamic> args;

  static AnnouncementSectionBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) {
    return AnnouncementSectionBuilder(
      Map<String, dynamic>.from(map['args'] ?? {}),
    );
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
    final widgetData =
        data.jsonWidgetArgs['data'] as Map<String, dynamic>? ?? {};

    return AnnouncementSection(
      showCategory: widgetData['showCategory'] ?? false,
      categoryType: widgetData['categoryType'] ?? 'subCategory',
      partnerId: widgetData['partnerId'],
    );
  }

  @override
  JsonWidgetBuilderModel createModel({
    required JsonWidgetData data,
    Widget Function(BuildContext, Widget)? childBuilder,
  }) {
    return EmptyModel(args);
  }
}
