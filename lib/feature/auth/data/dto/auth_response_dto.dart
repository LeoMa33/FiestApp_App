class AuthResponseDto {
  final String token;
  final String refreshToken;

  AuthResponseDto({required this.token, required this.refreshToken});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
