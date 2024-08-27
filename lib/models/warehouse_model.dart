// ignore: implementation_imports
import 'package:idempiere_rest/src/model_base.dart';

class Warehouse extends ModelBase {
  late String name;

  Warehouse(Map<String, dynamic> json) : super(json) {
    id = json['id'];
    name = json['name'];
  }

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(json);
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  ModelBase fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  String toString() {
    return 'Warehouse(id: $id, name: $name)';
  }
}
