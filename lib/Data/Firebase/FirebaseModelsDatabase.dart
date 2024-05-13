import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Model/ModelDTO.dart';
FirebaseModelsDatabase injectFirebaseModelsDatabase(){
  return FirebaseModelsDatabase.getInstance();
}

class  FirebaseModelsDatabase{

  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  FirebaseModelsDatabase._();
  static FirebaseModelsDatabase? instance;
  static getInstance(){
    return instance ??= FirebaseModelsDatabase._();
  }

  CollectionReference<ModelDTO> getCollectionReference(){
    return _firebaseStorage.collection("Models").withConverter(
      fromFirestore: (snapshot, options) => ModelDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<ModelDTO> getModel ({required String modelId})async {
    var response = await getCollectionReference().doc(modelId).get();
    return response.data()!;

  }

}