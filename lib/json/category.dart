import 'dart:convert';
Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      this.name, 
      this.length, 
      this.dueLength,});

  Category.fromJson(dynamic json) {
    name = json['name'];
    length = json['length'];
    dueLength = json['dueLength'];
  }
  String? name;
  String? length;
  String? dueLength;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['length'] = length;
    map['dueLength'] = dueLength;
    return map;
  }

}