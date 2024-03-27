class User {
  User({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.location,
    required this.email,
    required this.bio,
  });

  final String login;
  final int id;
  final String avatarUrl;
  final String email;
  final String location;
  final String bio;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatarUrl': avatarUrl,
      'location': location,
      'email': email,
      'bio': bio,
    };
  }
}
