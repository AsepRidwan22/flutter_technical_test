class UsersModel {
  final String email;
  final String isVerification;

  UsersModel({
    required this.email,
    required this.isVerification,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      email: json['email'] ?? '',
      isVerification: json['isVerification'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isVerification': isVerification,
    };
  }
}
