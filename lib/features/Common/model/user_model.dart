import 'dart:convert';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String avatarUrl;
  final String city;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.avatarUrl,
      required this.city});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['_id'],
        firstName: jsonData['first_name'] ?? '',
        lastName: jsonData['last_name']?? '',
        email: jsonData['email'],
        mobile: jsonData['phone']?? '',
        avatarUrl: jsonData['avatar_url']?? '',
        city: jsonData['city'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
  return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': mobile,
      'avatar_url': avatarUrl,
      'city': city
    };
  }
}
