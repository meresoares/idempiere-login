import 'package:idempiere_rest/src/model_base.dart';

class Role extends ModelBase {
  late String name;

  Role(Map<String, dynamic> json) : super(json) {
    id = json['id'];
    name = json['name'];
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(json);
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  ModelBase fromJson(Map<String, dynamic> json) {
    return Role.fromJson(json);
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Role && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
