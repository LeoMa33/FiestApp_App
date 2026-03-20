import 'dart:io';

import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class UserCreateDto {
  final String name;
  final String mail;
  final int age;
  final double weight;
  final double height;
  final AlcoholConsumption alcoholConsumption;
  final Gender gender;
  final File? profilePicture;

  UserCreateDto({
    required this.name,
    required this.mail,
    required this.age,
    required this.weight,
    required this.height,
    required this.alcoholConsumption,
    required this.gender,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mail': mail,
      'age': age,
      'weight': weight,
      'height': height,
      'alcohol_consumption': alcoholConsumption.name,
      'gender': gender.value,
    };
  }
}
