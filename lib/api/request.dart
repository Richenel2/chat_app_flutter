import 'dart:convert';

import 'package:sms/constantes/toast.dart';
import 'package:sms/models/message_model.dart';
import 'package:sms/models/user_model.dart';
import 'package:http/http.dart';

class Api {
  Api._privateConstructor();

  static final Api instance = Api._privateConstructor();
  static const String url = 'https://kayrachat.herokuapp.com';

  Future<User?> login(
      {required String email, required String password}) async {
    var response = await post(Uri.parse("$url/login"),
        body: {'email': email, 'password': password});
    if (response.statusCode != 200) {
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
    if (response.statusCode != 200) {
      return null;
    }
    return User.fromMap(json.decode(response.body));
  }

  Future updateUser(User user) async {
    await put(Uri.parse('$url/users/$user.id'), body: user.toMap());
  }

  Future<Message?> postMessage(
      {required int creatorId, required String message}) async {
    var reponse = await post(Uri.parse('$url/post_message/'),
        body: {'creator_id': creatorId, 'message': message});
    if (reponse.statusCode != 200) {
      return null;
    }
    return Message.fromMap(json.decode(reponse.body));
  }
}
