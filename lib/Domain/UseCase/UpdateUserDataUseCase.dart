import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';
import 'package:image_picker/image_picker.dart';

UpdateUserDataUseCase injectUpdateUserDataUseCase() {
  return UpdateUserDataUseCase(repository: injectUserRepository());
}

class UpdateUserDataUseCase {
  UserRepository repository;

  UpdateUserDataUseCase({required this.repository});

  Future<User> invoke(
      {required MyUser user, required User currentUser, XFile? file}) async {
    if (user.image
            .contains("https://firebasestorage.googleapis.com/v0/b/heimdall") &&
        file != null) {
      await repository.updateUserImageToDatabase(image: file, url: user.image);
    } else if (file != null) {
      var response = await repository.uploadUserImageToDatabase(image: file);
      await repository.updateUserImageInUserCredential(image: response);
      user.image = response;
    }
    if (user.name != currentUser.displayName) {
      currentUser = await repository.updateUserDisplayName(name: user.name);
    }
    await repository.updateUser(user: user);
    return currentUser;
  }
}
