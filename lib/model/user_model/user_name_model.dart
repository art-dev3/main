class Name {
  final String? firstName;
  final String? lastName;

  Name({this.firstName, this.lastName});

  factory Name.fromJson(Map<String, dynamic> data) {
    return Name(firstName: data['firstName'], lastName: data['lastName']);
  }

  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName};
  }
}
