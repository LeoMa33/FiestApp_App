import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class UserUpdateDto {
  final String? name;
  final String? mail;
  final bool? isEstimationActive;
  final DateTime? birthday;
  final int? weight;
  final int? height;
  final AlcoholConsumption? alcoholConsumption;
  final Gender? gender;

  UserUpdateDto({
    this.name,
    this.mail,
    this.isEstimationActive,
    this.birthday,
    this.weight,
    this.height,
    this.alcoholConsumption,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (mail != null) 'mail': mail,
      if (isEstimationActive != null) 'isEstimationActive': isEstimationActive,
      if (birthday != null) 'birthday': birthday!.toIso8601String(),
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (alcoholConsumption != null) 'alcohol_consumption': alcoholConsumption!.name,
      if (gender != null) 'gender': gender!.value,
    };
  }
}
