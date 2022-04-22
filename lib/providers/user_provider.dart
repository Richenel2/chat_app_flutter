import 'package:flutter/material.dart';
import 'package:sms/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future update({required String email,required String pseudo}) async {
    await _user!.update(e:email,p:pseudo);
    notifyListeners();
  }
}
