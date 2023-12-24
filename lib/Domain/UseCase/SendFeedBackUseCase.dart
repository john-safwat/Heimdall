import 'package:heimdall/Data/Repository/FeedbackRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Feedback/Feedback.dart';
import 'package:heimdall/Domain/Repository/FeedbackRepository.dart';

SendFeedBackUseCase injectSendFeedBackUseCase(){
  return SendFeedBackUseCase(repository: injectFeedbackRepository());
}

class SendFeedBackUseCase {

  FeedbackRepository repository;
  SendFeedBackUseCase({required this.repository});

  Future<void> invoke({required Feedback feedback})async {
    await repository.sendFeedback(feedback: feedback);
  }

}