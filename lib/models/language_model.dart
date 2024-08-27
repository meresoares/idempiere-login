// ignore: implementation_imports
import 'package:idempiere_rest/src/model_base.dart';

class Language extends ModelBase {
  late String identifier;

  Language(Map<String, dynamic> json) : super(json) {
    //id = json['id'];
    //identifier = json['Name'];
    identifier = json['AD_Language'];
  }

  @override
  Map<String, dynamic> toJson() {
    //return {'Name': identifier};
    return {'AD_Language': identifier};
  }

  @override
  Language fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    //identifier = json['Name'];
    identifier = json['AD_Language'];
    return this;
  }

  @override
  String toString() {
    return identifier; // Devuelve una representación significativa del objeto
  }
}
