import 'package:cloud_firestore/cloud_firestore.dart';

class Presence {
  final String? state;
  final DateTime? lastUpdated;

  Presence({this.state, this.lastUpdated});

  factory Presence.fromJson(Map<String, dynamic> data) {
    return Presence(
      state: data['state'],
      lastUpdated: data['last_updated'] != null
          ? (data['last_updated'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'last_updated': lastUpdated != null
          ? Timestamp.fromDate(lastUpdated!)
          : null,
    };
  }
}
