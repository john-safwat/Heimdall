import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

abstract class FirebaseLockCardRemoteDataSource {

  Future<void> addLock({required String uid , required LockCardDTO lockCard});

}