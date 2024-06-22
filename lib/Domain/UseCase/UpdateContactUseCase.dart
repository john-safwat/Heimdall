import 'package:heimdall/Data/Repository/ContactsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/Repository/ContactsRepository.dart';

UpdateContactUseCase injectUpdateContactUseCase(){
  return UpdateContactUseCase(repository: injectContactsRepository());
}

class UpdateContactUseCase {

  ContactsRepository repository;
  UpdateContactUseCase({required this.repository});

  Future<void> invoke({required Contact contact})async{
    await repository.updateContact(contact: contact);
  }

}