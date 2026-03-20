import 'package:fiestapp/feature/user/data/dto/user_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSessionState {
  final UserDto? user;
  final bool isLoading;

  UserSessionState({this.user, this.isLoading = false});

  UserSessionState copyWith({UserDto? user, bool? isLoading}) {
    return UserSessionState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserSessionNotifier extends StateNotifier<UserSessionState> {
  UserSessionNotifier() : super(UserSessionState());

  void setUser(UserDto user) {
    state = state.copyWith(user: user, isLoading: false);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void clear() {
    state = UserSessionState();
  }
}

final userSessionProvider =
    StateNotifierProvider<UserSessionNotifier, UserSessionState>((ref) {
      return UserSessionNotifier();
    });
