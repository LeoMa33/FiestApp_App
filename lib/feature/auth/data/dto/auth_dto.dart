class AuthDto {
  final String mail;
  final String password;

  AuthDto({required this.mail, required this.password});

  Map<String, dynamic> toJson() {
    return {'mail': mail, 'password': password};
  }
}
