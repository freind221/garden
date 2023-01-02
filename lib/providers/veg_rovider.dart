import 'package:flutter/cupertino.dart';
import 'package:slick_garden/models/vege_model.dart';

class VegetableProvider extends ChangeNotifier {
  Herbs _vegetables = Herbs(
      uid: '',
      vegeName: '',
      image: '',
      care: '',
      cropMonth: '',
      description: '',
      light: '',
      sowMonth: '',
      temprature: '',
      duration: '',
      waterAmount: '');

  setVegetable(
      String name,
      String image,
      String care,
      String desc,
      String cropMonth,
      String sowMonth,
      String temp,
      String duration,
      String water,
      light,
      uid) {
    _vegetables = Herbs(
        uid: uid,
        vegeName: name,
        image: image,
        care: care,
        cropMonth: cropMonth,
        description: desc,
        light: light,
        sowMonth: sowMonth,
        temprature: temp,
        duration: duration,
        waterAmount: water);
    notifyListeners();
  }

  Herbs get vegetables => _vegetables;
}
