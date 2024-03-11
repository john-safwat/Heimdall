import 'package:heimdall/Data/Models/Log/LogDTO.dart';

abstract class FirebaseLogRemoteDataSource {

  Future<void> addLog({required LogDTO log});

}