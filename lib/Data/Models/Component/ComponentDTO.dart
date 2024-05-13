import 'package:heimdall/Domain/Models/Component/Component.dart';

class ComponentDTO {

  String id;
  String name;
  String description;
  String type;
  String image;
  double cost;

  ComponentDTO({required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.image,
    required this.cost});

  ComponentDTO.fromFireStore(Map<String, dynamic> json) :this(
      name: json["name"],
      description: json["description"],
      type: json["type"],
      image: json["image"],
      cost: double.parse(json["cost"].toString()),
      id: json["id"]
  );

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "description": description,
      "type": type,
      "image": image,
      "cost": cost,
      "id": id
    };
  }

  Component toDomain() {
    return Component(id: id,
        name: name,
        description: description,
        type: type,
        image: image,
        cost: cost);
  }

}
