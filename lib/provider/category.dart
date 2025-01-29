import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/json/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier() : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesString = prefs.getString('categories');

    if (categoriesString == null || categoriesString.isEmpty) {
      // If no categories exist, add default categories
      state = [
        Category(name: 'all lists', length: '', dueLength: ''),
        Category(name: 'finished', length: '', dueLength: ''),
        Category(name: 'default', length: '', dueLength: ''),
      ];

      await prefs.setString('categories', json.encode(state.map((e) => e.toJson()).toList()));
    } else {
      // Load existing categories
      final List<dynamic> decoded = json.decode(categoriesString);
      state = decoded.map((e) => Category.fromJson(e)).toList();
    }
    /*
    if (categoriesString != null) {
      final List<dynamic> decoded = json.decode(categoriesString);
      state = decoded.map((e) => Category.fromJson(e)).toList();
    } else {
      state = [
        Category(name: 'all lists', length: '', dueLength: ''),
        Category(name: 'finished', length: '', dueLength: ''),
        Category(name: 'default', length: '', dueLength: ''),

      ];
    }

     */
  }

  Future<void> addCategory(Category category) async {
    if (!state.any((c) => c.name == category.name)) {
      final updatedList = [...state, category];
      state = updatedList;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('categories', json.encode(updatedList.map((e) => e.toJson()).toList()));
    }
  }
  Future<void> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesString = prefs.getString('categories');

    if (categoriesString == null || categoriesString.isEmpty) {
      print("No categories found in SharedPreferences.");
      return;
    }

    final List<dynamic> decoded = json.decode(categoriesString);
    final List<Category> categories = decoded.map((e) => Category.fromJson(e)).toList();

    print("Categories from SharedPreferences:");
    for (var category in categories) {
      print("Name: ${category.name}, Length: ${category.length}, Due Length: ${category.dueLength}");
    }
  }

}
