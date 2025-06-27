import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main/model/user_model/user_basic_info_model.dart';
import 'package:main/model/user_model/user_presence_model.dart';

class UserModel {
  final String uid;
  final String? imageUrl;
  final String? phoneNumber;
  final String? email;
  final String? username;
  final DateTime? createdAt;
  final BasicInfo? basicInfo;
  final Presence? presence;
  final String? token;

  UserModel({
    required this.uid,
    this.imageUrl,
    this.phoneNumber,
    this.email,
    this.username,
    this.createdAt,
    this.basicInfo,
    this.presence,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      imageUrl: data['imageUrl'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      username: data['username'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,

      basicInfo: data['basicInfo'] != null
          ? BasicInfo.fromJson(Map<String, dynamic>.from(data['basicInfo']))
          : null,
      presence: data['presence'] != null
          ? Presence.fromJson(Map<String, dynamic>.from(data['presence']))
          : null,
      token: data['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'basicInfo': basicInfo?.toJson(),
      'presence': presence?.toJson(),
      'token': token,
    };
  }
}
