import 'package:heimdall/Data/Models/Feedback/FeedbackDTO.dart';

class Feedback {
  String id;
  String uid;
  String message;
  double rating;
  String userName;
  String userEmail;
  String image;

  Feedback({
    required this.id,
    required this.uid,
    required this.message,
    required this.rating,
    required this.userName,
    required this.userEmail,
    required this.image,
  });

  FeedbackDTO toDataSource() {
    return FeedbackDTO(
        id: id,
        uid: uid,
        message: message,
        rating: rating,
        userName: userName,
        userEmail: userEmail,
        image: image);
  }
}
