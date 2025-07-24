class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String city;

  SignUpRequestModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      required this.city});

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
    };
  }
}
