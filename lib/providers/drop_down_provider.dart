import 'package:flutter/cupertino.dart';

class DropDownProvider extends ChangeNotifier {
  String _sowMonth = '';
  String _cropMonth = '';

  setSowMonth(String rol) {
    _sowMonth = rol;
    notifyListeners();
  }

  setCropMonth(String rol) {
    _cropMonth = rol;
    notifyListeners();
  }

  String get sowMonth => _sowMonth;
  String get cropMonth => _cropMonth;
}
