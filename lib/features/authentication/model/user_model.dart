import 'dart:convert';

// Converters
User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String username;
  final String password;

  User({
    this.id,
    this.fullName,
    this.email,
    required this.username,
    required this.password,
  });

  // Para salvar no banco
  Map<String, dynamic> toMap() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'username': username,
    'password': password,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    fullName: map['fullName'],
    email: map['email'],
    username: map['username'],
    password: map['password'],
  );

  // Para JSON (opcionalmente escondendo a senha)
  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'username': username,
    // 'password': password, // Opcional: não incluir
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'],
    email: json['email'],
    username: json['username'],
    password: json['password'],
  );
}
