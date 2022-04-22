import 'dart:convert';

import 'package:sms/constantes/toast.dart';
import 'package:sms/models/message_model.dart';
import 'package:sms/models/user_model.dart';
import 'package:http/http.dart';

class Api {
  Api._privateConstructor();

  static final Api instance = Api._privateConstructor();
  static const String url = 'https://kayrachat.herokuapp.com';

  Future<User?> login({required String email, required String password}) async {
    var response = await post(Uri.parse("$url/login"),
        body: {'email': email, 'password': password});
    if (response.statusCode.toString().length != 3 ||
        response.statusCode.toString()[0] != '2') {
      Toast.showAlertToast(json.decode(response.body)['message']);
      return null;
    }
    Toast.showDefaultToast('Connection succesfull');
    return User.fromMap(json.decode(response.body));
  }

  Future<User?> signin(
      {required String pseudo,
      required String password,
      required String email}) async {
    var response = await post(Uri.parse("$url/users/"), body: {
      'pseudo': pseudo,
      'password': password,
      'email': email,
      'username': pseudo
    });
    if (response.statusCode.toString().length != 3 ||
        response.statusCode.toString()[0] != '2') {
      Map<String, dynamic> body = json.decode(response.body);
      for (var e in body.values) {
        Toast.showAlertToast(e.toString());
      }
      return null;
    }
    return User.fromMap(json.decode(response.body));
  }

  Future<bool> updateUser(User user) async {
    var response =
        await put(Uri.parse('$url/users/${user.id}/'), body: user.toMap());
    if (response.statusCode.toString().length != 3 ||
        response.statusCode.toString()[0] != '2') {
      print(response.body);
      Map<String, dynamic> body = json.decode(response.body);
      for (var e in body.values) {
        Toast.showAlertToast(e.toString());
      }
      return false;
    }

    return true;
  }

  Future<Message?> postMessage(
      {required int creatorId, required String message}) async {
    var reponse = await post(Uri.parse('$url/post_message'),
        body: {'creator_id': "$creatorId", 'message': message});
    if (reponse.statusCode != 200) {
      Toast.showAlertToast(reponse.body);
      return null;
    }
    return null;
  }

  Future<List<Message>?> getMessage() async {
    var response = await get(Uri.parse('$url/messages'));
    if (response.statusCode.toString().length != 3 ||
        response.statusCode.toString()[0] != '2') {
      Map<String, dynamic> body = json.decode(response.body);
      for (var e in body.values) {
        Toast.showAlertToast(e.toString());
      }
      return null;
    }
    List message = json.decode(response.body);
    List<Message> messages = message.map((e) => Message.fromMap(e)).toList();
    return messages;
  }
}
