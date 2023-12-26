
import 'package:heimdall/Domain/Models/Feedback/Feedback.dart';

abstract class FeedbackRepository {
  Future<String> sendFeedback({required Feedback feedback});
  Future<void> deleteUserFeedbacks({required String uid});

}