import 'package:main/model/user_model/user_address_model.dart';
import 'package:main/model/user_model/user_name_model.dart';

class BasicInfo {
  final Address? address;
  final String? barangay;
  final String? city;
  final String? country;
  final String? province;
  final String? region;
  final String? street;
  final String? bio;
  final String? birthdate;
  final String? civilStatus;
  final String? employment;
  final String? gender;
  final Name? name;

  BasicInfo({
    this.address,
    this.barangay,
    this.city,
    this.country,
    this.province,
    this.region,
    this.street,
    this.bio,
    this.birthdate,
    this.civilStatus,
    this.employment,
    this.gender,
    this.name,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> data) {
    return BasicInfo(
      address: data['address'] != null
          ? Address.fromJson(Map<String, dynamic>.from(data['address']))
          : null,
      barangay: data['barangay'],
      city: data['city'],
      country: data['country'],
      province: data['province'],
      region: data['region'],
      street: data['street'],
      bio: data['bio'],
      birthdate: data['birthdate'],
      civilStatus: data['civilStatus'],
      employment: data['employment'],
      gender: data['gender'],
      name: data['name'] != null
          ? Name.fromJson(Map<String, dynamic>.from(data['name']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address?.toJson(),
      'barangay': barangay,
      'city': city,
      'country': country,
      'province': province,
      'region': region,
      'street': street,
      'bio': bio,
      'birthdate': birthdate,
      'civilStatus': civilStatus,
      'employment': employment,
      'gender': gender,
      'name': name?.toJson(),
    };
  }
}
