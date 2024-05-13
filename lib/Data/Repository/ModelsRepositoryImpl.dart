
import 'package:heimdall/Data/DataSource/FirebaseModelsRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseModelsRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Model/Model.dart';
import 'package:heimdall/Domain/Repository/ModelsRepository.dart';

ModelsRepository injectModelsRepository(){
  return ModelsRepositoryImpl(remoteDataSource: injectFirebaseModelsRemoteDataSource());
}

class ModelsRepositoryImpl implements ModelsRepository{

  FirebaseModelsRemoteDataSource remoteDataSource;
  ModelsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Model> getModel({required String modelId})async {
    var response = await remoteDataSource.getModel(modelId: modelId);
    return response;
  }

}