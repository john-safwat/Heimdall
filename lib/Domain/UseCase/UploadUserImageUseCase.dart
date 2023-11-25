import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';
import 'package:image_picker/image_picker.dart';


UploadUserImageUseCase injectUploadUserImageUseCase(){
  return UploadUserImageUseCase(repository: injectUserRepository());
}

class UploadUserImageUseCase {

  UserRepository repository;
  UploadUserImageUseCase({required this.repository});

  Future<User> invoke({required String local , required XFile image})async{
    var imageURL = await repository.uploadUserImageToDatabase(local: local, image: image);
    var response = await repository.updateUserImageInUserCredential(local: local, image: imageURL);
    return response;
  }

}