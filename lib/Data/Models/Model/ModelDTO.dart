
import 'package:heimdall/Data/Models/Component/ComponentDTO.dart';
import 'package:heimdall/Domain/Models/Model/Model.dart';

class ModelDTO {
  String? id;
  String? name;
  String? image;
  List<ComponentDTO>? components;

  ModelDTO({
      this.id, 
      this.name, 
      this.image,
      this.components,});

  ModelDTO.fromFireStore(Map<String , dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['components'] != null) {
      components = [];
      json['components'].forEach((v) {
        components?.add(ComponentDTO.fromFireStore(v));
      });
    }
  }

  Map<String, dynamic> toFireStore() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    if (components != null) {
      map['components'] = components?.map((v) => v.toFireStore()).toList();
    }
    return map;
  }

  Model toDomain(){
    return Model(
      components: components!.map((e) => e.toDomain()).toList(),
      id: id,
      image: image,
      name: name
    );
  }

}