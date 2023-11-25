import 'package:heimdall/Data/Models/Users/UserDTO.dart';

class MyUser {
  String uid;
  String name;
  String email;
  String password;
  String image;
  String phoneNumber;
  String birthDate;
  String gender;

  MyUser(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.image,
      required this.phoneNumber,
      required this.birthDate,
      required this.gender});

  UserDTO toDataSource() {
    return UserDTO(
        uid: uid,
        name: name,
        email: email,
        password: password,
        image: image,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        gender: gender);
  }
}
