import 'dart:convert';
Task taskFromJson(String str) => Task.fromJson(json.decode(str));
String taskToJson(Task data) => json.encode(data.toJson());
class Task {
  Task({
      this.id, 
      this.name, 
      this.date, 
      this.time, 
      this.isCompleted,});

  Task.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    isCompleted = json['isCompleted'];
  }
  String? id;
  String? name;
  String? date;
  String? time;
  String? isCompleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['date'] = date;
    map['time'] = time;
    map['isCompleted'] = isCompleted;
    return map;
  }

}