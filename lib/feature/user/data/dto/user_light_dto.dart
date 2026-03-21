class UserLightDto {
  final String id;
  final String name;
  final String? imageUrl;

  UserLightDto({required this.id, required this.name, this.imageUrl});

  factory UserLightDto.fromJson(Map<String, dynamic> json) {
    return UserLightDto(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  String get avatarOrPlaceholder =>
      imageUrl ?? 'https://ui-avatars.com/api/?name=${name[0]}';
}
