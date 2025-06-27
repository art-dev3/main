class Address {
  final String? street;
  final String? barangay;
  final String? city;
  final String? province;
  final String? region;
  final String? country;

  Address({
    this.street,
    this.barangay,
    this.city,
    this.province,
    this.region,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> data) {
    return Address(
      street: data['street'],
      barangay: data['barangay'],
      city: data['city'],
      province: data['province'],
      region: data['region'],
      country: data['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'barangay': barangay,
      'city': city,
      'province': province,
      'region': region,
      'country': country,
    };
  }
}
