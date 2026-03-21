import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';

class UserUpdateDto {
  final String? name;
  final String? mail;
  final int? age;
  final int? weight;
  final int? height;
  final AlcoholConsumption? alcoholConsumption;

  UserUpdateDto({
    this.name,
    this.mail,
    this.age,
    this.weight,
    this.height,
    this.alcoholConsumption,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (mail != null) data['mail'] = mail;
    if (age != null) data['age'] = age;
    if (weight != null) data['weight'] = weight;
    if (height != null) data['height'] = height;
    if (alcoholConsumption != null) {
      data['alcohol_consumption'] = alcoholConsumption!.name;
    }

    return data;
  }
}
