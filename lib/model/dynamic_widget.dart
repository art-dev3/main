class DynamicWidget {
  final String type;
  final Map<String, dynamic>? properties;
  final List<DynamicWidget>? children;
  DynamicWidget({required this.type, this.properties, this.children});
  factory DynamicWidget.fromJson(Map<String, dynamic> json) {
    return DynamicWidget(
      type: json['type'],
      properties: json['properties'],
      children: json['children'] != null
          ? (json['children'] as List)
                .map((child) => DynamicWidget.fromJson(child))
                .toList()
          : null,
    );
  }
}
