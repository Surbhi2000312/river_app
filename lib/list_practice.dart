

import 'dart:convert';

import 'package:river_app/json/category.dart';

void main() {

  var list = [1, 2, 3];

  assert(list.length == 3);
  assert(list[1] == 2);

  list[1] = 1;
  assert(list[1] == 1);

  Category category = Category(
    name: "Work",
    length: "10",
    dueLength: "5",
  );

  // JSON me convert karna
  String jsonString = categoryToJson(category);
  print(jsonString);// {"name":"Work","length":"10","dueLength":"5"}
  print('\n');

  List<Category> categories = [
    Category(name: "Work", length: "10", dueLength: "5"),
    Category(name: "Personal", length: "7", dueLength: "3"),
  ];

  // List ko JSON me convert karna
  String jsonString2 = jsonEncode(categories.map((cat) => cat.toJson()).toList());
  print(jsonString2);
  print('\n');

// Har ek category ko JSON me convert karke print karna
  categories.forEach((cat) {
    String jsonString = jsonEncode(cat.toJson());
    print(jsonString);
  });

  categories.removeWhere((cat) => cat.name == "Work");

  List<String> jsonStringList =
  categories.map((cat) => jsonEncode(cat.toJson())).toList();

  // await prefs.setStringList("categories_key", jsonStringList);

  print("Updated List Saved: $jsonStringList");

}