import 'package:heimdall/Domain/Models/Model/Model.dart';

abstract class FirebaseModelsRemoteDataSource {

  Future<Model> getModel({required String modelId});

}