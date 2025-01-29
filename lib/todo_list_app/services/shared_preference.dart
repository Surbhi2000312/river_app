import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceService{
  final SharedPreferences sharedPreferences;

  SharedPreferenceService(this.sharedPreferences);


  Future<void>addTodo(String value)async {
    final result = await SharedPreferences.getInstance();
  }

}
