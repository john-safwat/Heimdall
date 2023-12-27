import 'package:heimdall/Data/Repository/ContactsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/FeedbackRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/ContactsRepository.dart';
import 'package:heimdall/Domain/Repository/FeedbackRepository.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';


DeleteUserAccountUseCase injectDeleteUserAccountUseCase(){
  return DeleteUserAccountUseCase(
    userRepository: injectUserRepository(),
    contactsRepository: injectContactsRepository(),
    feedbackRepository: injectFeedbackRepository()
  );
}

class DeleteUserAccountUseCase {

  UserRepository userRepository;
  ContactsRepository contactsRepository;
  FeedbackRepository feedbackRepository;

  DeleteUserAccountUseCase({
    required this.userRepository,
    required this.contactsRepository,
    required this.feedbackRepository
  });

  Future<void> invoke({required String uid})async{
    await userRepository.deleteAccount(uid: uid);
    await contactsRepository.deleteUserContacts(uid: uid);
    await feedbackRepository.deleteUserFeedbacks(uid: uid);
  }

}