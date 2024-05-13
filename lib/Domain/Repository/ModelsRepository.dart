import 'package:heimdall/Domain/Models/Model/Model.dart';

abstract class ModelsRepository {

  Future<Model> getModel({required String modelId});

}