import 'package:heimdall/Data/Models/Feedback/FeedbackDTO.dart';

abstract class FirebaseFeedbackRemoteDataSource {
  Future<String> sendFeedback({required FeedbackDTO feedback});
}