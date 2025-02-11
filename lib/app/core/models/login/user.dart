class User {
  const User({
    required this.accessToken,
    required this.avatar,
    required this.clientID,
    required this.fkUserID,
    required this.fullName,
    required this.role,
    required this.userActivation,
    required this.userName,
    required this.passwordBySystem,
  });

  final String accessToken;
  final String avatar;
  final String clientID;
  final String fkUserID;
  final String fullName;
  final String role;
  final bool userActivation;
  final String userName;
  final String passwordBySystem;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        accessToken: json["access_token"] as String,
        avatar: json["avatar"] as String,
        clientID: json["client_id"] as String,
        fkUserID: json["fk_user_id"] as String,
        fullName: json["fullname"] as String,
        passwordBySystem: json["password_by_system"] as String,
        role: json["role"] as String,
        userActivation: json["user_activation"] as bool,
        userName: json["username"] as String);
  }
}
