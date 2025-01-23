import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/task/show_data.dart';
import 'package:river_app/widgets/edt.dart';

void main() {
  runApp(ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigoAccent.shade700,
          elevation: 5,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
          iconTheme: IconThemeData(color: Colors.white,size: 30),
          actionsIconTheme: IconThemeData(color: Colors.white, size: 16.0),
          systemOverlayStyle: SystemUiOverlayStyle(
            // statusBarColor: Colors.white.withOpacity(.5),
            statusBarColor: Colors.black.withOpacity(.3),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.indigo,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 25).apply(color: Colors.white),
          bodyLarge: TextStyle(fontSize: 25).apply(color: Colors.white)
        ),
        // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        // textTheme: Typography(platform: TargetPlatform.iOS).white,
      ),
      home: ShowData(),
    );
  }
}

// Todo model
class Todo {
  final int id;
  final String workName;
  final DateTime dateTime;
  bool isCompleted;

  Todo({
    required this.id,
    required this.workName,
    required this.dateTime,
    this.isCompleted = false,
  });
}

// Riverpod provider for managing todos
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
      (ref) => TodoListNotifier(),
);

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(int id, String workName, DateTime dateTime) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          workName: workName,
          dateTime: dateTime,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();
  }

  void toggleComplete(int id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          workName: todo.workName,
          dateTime: todo.dateTime,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
  }

  void deleteTodoById(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
