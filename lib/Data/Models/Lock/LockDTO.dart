import 'package:heimdall/Domain/Models/Lock/Lock.dart';

class LockDTO {
  LockDTO({required this.id,
    required this.email,
    required this.password,
    required this.firstOwner,
    required this.model,
    required this.createdAt,
    required this.images});

  LockDTO.fromJson(dynamic json){
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstOwner = json['firstOwner'];
    model = json['model'];
    createdAt = json["createdAt"];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add((v as String));
      });
    }
  }

  late String id;
  late String email;
  late String password;
  late String firstOwner;
  late int createdAt;
  late String model;
  late List<String> images = [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'firstOwner': firstOwner,
      'model': model,
      "createdAt": createdAt,
      "images": images
    };
  }

  Lock toDomain() {
    return Lock(id: id,
        email: email,
        password: password,
        firstOwner: firstOwner,
        model: model,
        createdAt: createdAt,
        images: images);
  }

}

