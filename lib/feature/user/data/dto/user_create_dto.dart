import 'dart:io';

import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class UserCreateDto {
  final String name;
  final DateTime birthday;
  final int? weight;
  final int? height;
  final bool isEstimationActive;
  final AlcoholConsumption? alcoholConsumption;
  final Gender? gender;
  final File? profilePicture;

  UserCreateDto({
    required this.name,
    required this.birthday,
    this.weight,
    this.height,
    this.isEstimationActive = true,
    this.alcoholConsumption,
    this.gender,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday.toIso8601String(),
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      'isEstimationActive': isEstimationActive,
      if (alcoholConsumption != null)
        'alcohol_consumption': alcoholConsumption!.name,
      if (gender != null) 'gender': gender!.value,
    };
  }
}
