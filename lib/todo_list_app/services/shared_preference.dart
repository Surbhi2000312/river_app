import 'dart:convert';

import 'package:river_app/constant/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../json/task.dart';


class SharedPreferenceService {
  final SharedPreferences prefs;

  SharedPreferenceService(this.prefs);


  Future<void> addTodo(String value) async {
    final result = prefs.getStringList(StringConst.item);
    result?.add(value);

    await prefs.setStringList(StringConst.item, result ?? []);
  }

  Future<List<String>> getTodo() async {
    var c = prefs.getStringList(StringConst.item) ?? [];
    print('object $c');
    return prefs.getStringList(StringConst.item) ?? [];
  }

  static Future<List<String>> getTodoStatic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var c = prefs.getStringList(StringConst.item) ?? [];
    print('object $c');
    return prefs.getStringList(StringConst.item) ?? [];
  }

  Future<void> removeTodo(int index) async {
    final result = prefs.getStringList(StringConst.item);
    result?.removeAt(index);
    await prefs.setStringList(StringConst.item, result ?? []);
  }

}