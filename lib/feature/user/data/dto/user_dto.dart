import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class UserDto {
  final String id;
  final String name;
  final String mail;
  final bool isEstimationActive;
  final int age;
  final DateTime birthday;
  final int? weight;
  final String? imageUrl;
  final int? height;
  final Gender? gender;
  final AlcoholConsumption? alcoholConsumption;

  UserDto({
    required this.id,
    required this.name,
    required this.mail,
    required this.isEstimationActive,
    required this.age,
    required this.birthday,
    this.weight,
    this.imageUrl,
    this.height,
    this.gender,
    this.alcoholConsumption,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final birthday = DateTime.parse(json['birthday'] as String);

    final int age = json['age'] != null
        ? (json['age'] as num).toInt()
        : _calculateAge(birthday);

    return UserDto(
      id: json['id'] as String,
      name: json['name'] as String,
      mail: json['mail'] as String,
      isEstimationActive: json['isEstimationActive'] as bool? ?? false,
      age: age,
      birthday: birthday,
      weight: json['weight'] != null ? (json['weight'] as num).toInt() : null,
      imageUrl: json['imageUrl'] as String?,
      height: json['height'] != null ? (json['height'] as num).toInt() : null,
      gender: json['gender'] != null
          ? Gender.fromString(json['gender'] as String)
          : null,
      alcoholConsumption: json['alcohol_consumption'] != null
          ? AlcoholConsumption.values.byName(
              json['alcohol_consumption'] as String,
            )
          : null,
    );
  }

  static int _calculateAge(DateTime birthday) {
    final today = DateTime.now();

    int age = today.year - birthday.year;

    if (today.month < birthday.month ||
        (today.month == birthday.month && today.day < birthday.day)) {
      age--;
    }

    return age;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'isEstimationActive': isEstimationActive,
      'age': age,
      'birthday': birthday.toIso8601String(),
      'weight': weight,
      'imageUrl': imageUrl,
      'height': height,
      'gender': gender?.value,
      'alcohol_consumption': alcoholConsumption?.name,
    };
  }
}
