class Herbs {
  final String uid;
  final String vegeName;
  final String image;
  final String waterAmount;
  final String light;
  final String temprature;
  final String sowMonth;
  final String cropMonth;
  final String description;
  final String care;
  final String duration;

  Herbs(
      {required this.uid,
      required this.vegeName,
      required this.image,
      required this.care,
      required this.cropMonth,
      required this.description,
      required this.light,
      required this.sowMonth,
      required this.temprature,
      required this.duration,
      required this.waterAmount});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': vegeName,
      'image': image,
      'care': care,
      'cropMonth': cropMonth,
      'description': description,
      'light': light,
      'sowMonth': sowMonth,
      'temprature': temprature,
      'waterAmount': waterAmount,
      'duration': duration
    };
  }

  factory Herbs.fromMap(Map<String, dynamic> map) {
    return Herbs(
      uid: map['uid'] ?? '',
      vegeName: map['name'] ?? '',
      image: map['image'] ?? '',
      care: map['care'] ?? '',
      cropMonth: map['cropMonth'] ?? '',
      description: map['description'] ?? '',
      light: map['light'] ?? '',
      sowMonth: map['sowMonth'] ?? '',
      temprature: map['temprature'] ?? '',
      waterAmount: map['waterAmount'] ?? '',
      duration: map['duration'] ?? '',
    );
  }
}
