class User {
  final int? id;
  final String fullName;
  final String email; // agora o email é único
  final String password;
  final String? diet;
  final int? calories;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.diet,
    this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'diet': diet,
      'calories': calories,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      diet: map['diet'],
      calories: map['calories'],
    );
  }
}
