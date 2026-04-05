import 'dart:io';

import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';
import 'package:fiestapp/feature/user/data/dto/user_create_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCreateState {
  final String name;
  final DateTime? birthday;
  final int weight;
  final int height;
  final AlcoholConsumption alcoholConsumption;
  final Gender gender;
  final File? profilePicture;
  final bool isEstimationActive;

  UserCreateState({
    this.name = '',
    this.birthday,
    this.weight = 70,
    this.height = 170,
    this.alcoholConsumption = AlcoholConsumption.never,
    this.gender = Gender.man,
    this.profilePicture,
    this.isEstimationActive = true,
  });

  UserCreateState copyWith({
    String? name,
    DateTime? birthday,
    int? weight,
    int? height,
    AlcoholConsumption? alcoholConsumption,
    Gender? gender,
    File? profilePicture,
    bool? isEstimationActive,
  }) {
    return UserCreateState(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
      gender: gender ?? this.gender,
      profilePicture: profilePicture ?? this.profilePicture,
      isEstimationActive: isEstimationActive ?? this.isEstimationActive,
    );
  }

  UserCreateDto toDto() {
    UserCreateDto dto = UserCreateDto(
      name: name,
      birthday:
          birthday ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
      weight: isEstimationActive ? weight : null,
      height: isEstimationActive ? height : null,
      isEstimationActive: isEstimationActive,
      alcoholConsumption: isEstimationActive ? alcoholConsumption : null,
      gender: gender,
      profilePicture: profilePicture,
    );

    return dto;
  }
}

class UserCreateNotifier extends StateNotifier<UserCreateState> {
  UserCreateNotifier() : super(UserCreateState());

  void updateName(String name) => state = state.copyWith(name: name);
  void updateBirthday(DateTime birthday) =>
      state = state.copyWith(birthday: birthday);
  void updateWeight(int weight) => state = state.copyWith(weight: weight);
  void updateHeight(int height) => state = state.copyWith(height: height);
  void updateAlcoholConsumption(AlcoholConsumption consumption) =>
      state = state.copyWith(alcoholConsumption: consumption);
  void updateGender(Gender gender) => state = state.copyWith(gender: gender);
  void updateProfilePicture(File? file) =>
      state = state.copyWith(profilePicture: file);
  void updateEstimationActive(bool active) =>
      state = state.copyWith(isEstimationActive: active);
}

final userCreateProvider =
    StateNotifierProvider<UserCreateNotifier, UserCreateState>((ref) {
      return UserCreateNotifier();
    });
