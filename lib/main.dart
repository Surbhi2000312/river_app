import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:river_app/category_and_task/task_page.dart';
import 'package:river_app/practice_ui/flutter_toast_n_snackBar.dart';
import 'package:river_app/task/show_data.dart';
import 'package:river_app/todo_list_app/screens/todo_list_home.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugins are initialized
  runApp(ProviderScope(child: TodoApp()));
  // Task task = Task(id: "1", name: "Test", date: "2024-01-01", time: "10:00", isCompleted: 'false');
  // Task updatedTask = task.copyWith(name: "Updated Name");
}


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
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

      ),
      // home: ShowData(),
      // home: TodoListHomeScreen(),
      // practice UI component
      home: PracticeToastSnack(),
    );
  }
}





