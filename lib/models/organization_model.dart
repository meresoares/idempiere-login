import 'package:idempiere_rest/src/model_base.dart';

class Organization extends ModelBase {
  late String name;

  Organization(Map<String, dynamic> json) : super(json) {
    id = json['id'];
    name = json['name'];
  }

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(json);
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  ModelBase fromJson(Map<String, dynamic> json) {
    return Organization.fromJson(json);
  }
}
