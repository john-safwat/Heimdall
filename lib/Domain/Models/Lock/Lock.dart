import 'package:heimdall/Data/Models/Lock/LockDTO.dart';

class Lock {
  Lock({required this.id,
    required this.email,
    required this.password,
    required this.firstOwner,
    required this.model,
    required this.createdAt,
    required this.images});

  String id;
  String email;
  String password;
  String firstOwner;
  int createdAt;
  String model;
  List<String> images = [];

  LockDTO toDataSource() {
    return LockDTO(id: id,
        email: email,
        password: password,
        firstOwner: firstOwner,
        model: model,
        createdAt: createdAt,
        images: images);
  }

}