import 'package:heimdall/Domain/Models/Users/User.dart';

class UserDTO {
  String uid;
  String name;
  String email;
  String password;
  String image;
  String phoneNumber;
  String birthDate;
  String gender;

  UserDTO(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.image,
      required this.phoneNumber,
      required this.birthDate,
      required this.gender});

  UserDTO.fromFireStore(Map<String, dynamic> json)
      : this(
          uid: json["uid"],
          name: json["name"],
          email: json["email"],
          password: json["password"],
          image: json["image"],
          phoneNumber: json["phoneNumber"],
          birthDate: json["birthDate"],
          gender: json["gender"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "password": password,
      "image": image,
      "phoneNumber": phoneNumber,
      "birthDate": birthDate,
      "gender": gender
    };
  }

  MyUser toDomain() {
    return MyUser(
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
