
import 'package:heimdall/Domain/Models/Component/Component.dart';

class Model {
  String? id;
  String? name;
  String? image;
  List<Component>? components;

  Model({
      this.id, 
      this.name, 
      this.image,
      this.components,});

}