import 'package:sms/api/request.dart';
import 'package:sms/databases/database.dart';
import 'package:sqflite/sqflite.dart';

class User {
  int id;
  String pseudo;
  String email;
  String? image;

  User(
      {required this.id,
      required this.pseudo,
      required this.email,
      this.image});

  factory User.fromMap(Map<String, dynamic> map) => User(
      id: map['id'],
      pseudo: map['pseudo'],
      email: map['email'],
      image: map['image']);

  Map<String, dynamic> toMap() {
    return {'id': id.toString(), 'pseudo': pseudo, 'email': email, 'image': image};
  }

  Future save() async {
    Database db = await MyDatabase.instance.database;
    id = await db.insert('User', toMap());
  }

  Future update({required String e, required String p}) async {
    email = e;
    pseudo = p;
    bool okay = await Api.instance.updateUser(this);
    if (okay) {
      Database db = await MyDatabase.instance.database;
      await db.update('User', toMap(), where: "id = ?", whereArgs: [id]);
    }
  }

  Future delete() async {
    Database db = await MyDatabase.instance.database;
    id = await db.delete('User', where: "id=?", whereArgs: [id]);
  }
}
