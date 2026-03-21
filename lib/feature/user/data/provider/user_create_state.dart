import 'dart:io';

import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';
import 'package:fiestapp/feature/user/data/dto/user_create_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCreateState {
  final String name;
  final String mail;
  final int age;
  final double weight;
  final double height;
  final AlcoholConsumption alcoholConsumption;
  final Gender gender;
  final File? profilePicture;

  UserCreateState({
    this.name = '',
    this.mail = '',
    this.age = 18,
    this.weight = 70.0,
    this.height = 1.70,
    this.alcoholConsumption = AlcoholConsumption.casual,
    this.gender = Gender.man,
    this.profilePicture,
  });

  UserCreateState copyWith({
    String? name,
    String? mail,
    int? age,
    double? weight,
    double? height,
    AlcoholConsumption? alcoholConsumption,
    Gender? gender,
    File? profilePicture,
  }) {
    return UserCreateState(
      name: name ?? this.name,
      mail: mail ?? this.mail,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
      gender: gender ?? this.gender,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  UserCreateDto toDto() {
    return UserCreateDto(
      name: name,
      mail: mail,
      age: age,
      weight: (weight * 1000).toInt(),
      height: (height * 100).toInt(),
      alcoholConsumption: alcoholConsumption,
      gender: gender,
      profilePicture: profilePicture,
    );
  }
}

class UserCreateNotifier extends StateNotifier<UserCreateState> {
  UserCreateNotifier() : super(UserCreateState());

  void updateName(String name) => state = state.copyWith(name: name);
  void updateMail(String mail) => state = state.copyWith(mail: mail);
  void updateAge(int age) => state = state.copyWith(age: age);
  void updateWeight(double weight) => state = state.copyWith(weight: weight);
  void updateHeight(double height) => state = state.copyWith(height: height);
  void updateAlcoholConsumption(AlcoholConsumption consumption) =>
      state = state.copyWith(alcoholConsumption: consumption);
  void updateGender(Gender gender) => state = state.copyWith(gender: gender);
  void updateProfilePicture(File? file) =>
      state = state.copyWith(profilePicture: file);
}

final userCreateProvider =
    StateNotifierProvider<UserCreateNotifier, UserCreateState>((ref) {
      return UserCreateNotifier();
    });
