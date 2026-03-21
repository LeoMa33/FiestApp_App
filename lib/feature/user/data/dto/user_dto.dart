import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';

class UserDto {
  final String id;
  final String name;
  final String mail;
  final int age;
  final int weight;
  final String? imageUrl;
  final int height;
  final AlcoholConsumption alcoholConsumption;
  final Gender gender;

  UserDto({
    required this.id,
    required this.name,
    required this.mail,
    required this.age,
    required this.weight,
    this.imageUrl,
    required this.height,
    required this.alcoholConsumption,
    required this.gender,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserDto(
      id: json['id'] as String,
      name: json['name'] as String,
      mail: json['mail'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      height: (json['height'] as num).toInt(),
      alcoholConsumption: AlcoholConsumption.values.byName(
        json['alcohol_consumption'] as String,
      ),
      gender: Gender.fromString(json['gender'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'age': age,
      'weight': weight,
      'imageUrl': imageUrl,
      'height': height,
      'alcohol_consumption': alcoholConsumption.name,
      'gender': gender.value,
    };
  }
}
