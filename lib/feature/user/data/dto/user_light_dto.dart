class UserLightDto {
  final String id;
  final String mail;
  final String? imageUrl;

  UserLightDto({required this.id, required this.mail, this.imageUrl});

  factory UserLightDto.fromJson(Map<String, dynamic> json) {
    return UserLightDto(
      id: json['id'] as String,
      mail: json['mail'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'mail': mail, 'imageUrl': imageUrl};
  }

  String get avatarOrPlaceholder =>
      imageUrl ?? 'https://ui-avatars.com/api/?name=${mail[0]}';
}
