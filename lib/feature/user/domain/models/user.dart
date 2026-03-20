import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class User {
  final String userGuid;
  final String username;
  final Gender gender;
  final int age;
  final int height;
  final int weight;
  final String alcoholConsumption;
  final String? ppLink;

  User({
    required this.userGuid,
    required this.username,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.alcoholConsumption,
    required this.ppLink,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userGuid: json['guid'] as String,
      username: json['username'] as String,
      gender: Gender.fromString(json['gender'] as String),
      age: json['age'] as int,
      height: json['height'] as int,
      weight: json['weight'] as int,
      alcoholConsumption: json['alcohol_consumption'] as String,
      ppLink: json['pp_link'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'gender': gender.value,
      'age': age,
      'weight': weight,
      'height': height,
      'alcohol_consumption': alcoholConsumption,
    };
  }

  User copyWith({
    String? userGuid,
    String? username,
    Gender? gender,
    int? age,
    int? height,
    int? weight,
    String? alcoholConsumption,
    String? ppLink,
  }) {
    return User(
      userGuid: userGuid ?? this.userGuid,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
      ppLink: ppLink ?? this.ppLink,
    );
  }
}
