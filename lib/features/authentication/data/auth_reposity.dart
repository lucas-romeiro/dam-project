import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'package:dam_project/features/authentication/model/user_model.dart';

class AuthReposity {
  static const String _dbName = 'users.db';
  static const String _tableName = 'users';

  static Database? _database;

  // SQL para criação da tabela
  static const String _createTableSQL = '''
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullName TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      diet TEXT,
      calories INTEGER
    )
  ''';

  // Singleton do banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Inicializa o banco
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(_createTableSQL);
      },
    );
  }

  // Criptografia da senha (hash SHA-256)
  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // Verifica credenciais de login
  Future<bool> authenticate(User user) async {
    final db = await database;
    final hashedPassword = _hashPassword(user.password);

    final result = await db.query(
      _tableName,
      where: 'email = ? AND password = ?',
      whereArgs: [user.email, hashedPassword],
    );

    return result.isNotEmpty;
  }

  // Cria novo usuário
  Future<int> createUser(User user) async {
    final db = await database;
    final userMap = user.toMap();
    userMap['password'] = _hashPassword(user.password);

    return await db.insert(_tableName, userMap);
  }

  // Busca usuário pelo email
  Future<User?> getUser(String email) async {
    final db = await database;

    final result = await db.query(
      _tableName,
      where: 'email = ?',
      whereArgs: [email],
    );

    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  // Verifica se email já existe
  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Função para atualizar os dados do usuário
  Future<int> updateUser(User user) async {
    final db = await database;

    // Criação do mapa de dados para atualização
    final userMap = {
      'fullName': user.fullName,
      'email': user.email,
      'diet': user.diet,
      'calories': user.calories,
    };

    // Atualização do usuário no banco de dados
    return await db.update(
      _tableName,
      userMap,
      where:
          'email = ?', // Usando o `email` como referência para identificar o usuário
      whereArgs: [user.email],
    );
  }
}
