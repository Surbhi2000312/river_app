import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/json/Task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// Import your Task model here

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  Future<void> loadTasks() async {
    print('load task');
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    print(tasksJson);
    if (tasksJson != null) {
      final tasksList = json.decode(tasksJson) as List;
      state = tasksList.map((e) => Task.fromJson(e)).toList();
    }
  }

  Future<void> addTask(Task task) async {
    state = [...state, task];
    await saveTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(state.map((task) => task.toJson()).toList());
    print("set => $tasksJson");
    await prefs.setString('tasks', tasksJson);
  }
}
