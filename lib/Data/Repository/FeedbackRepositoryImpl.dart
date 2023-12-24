import 'package:heimdall/Data/DataSource/FirebaseFeedbackRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseFeedbackRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Feedback/Feedback.dart';
import 'package:heimdall/Domain/Repository/FeedbackRepository.dart';

FeedbackRepository injectFeedbackRepository(){
  return FeedbackRepositoryImpl(remoteDataSource: injectFirebaseFeedbackRemoteDataSource());
}

class FeedbackRepositoryImpl implements FeedbackRepository {

  FirebaseFeedbackRemoteDataSource remoteDataSource;
  FeedbackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> sendFeedback({required Feedback feedback}) async{
    var response = await remoteDataSource.sendFeedback(feedback: feedback.toDataSource());
    return response;
  }

}