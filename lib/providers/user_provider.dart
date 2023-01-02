import 'package:flutter/cupertino.dart';
import 'package:slick_garden/models/user_model.dart';

class UserProvide extends ChangeNotifier {
  User _user = User(uid: '', username: '', email: '');

  User get user => _user;
  setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
