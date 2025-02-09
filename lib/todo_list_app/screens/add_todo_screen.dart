import 'package:flutter/material.dart';
import 'package:river_app/todo_list_app/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),

              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'creating a record',
                  fillColor: Colors.white70
                ),
              ),
              const SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16
                ),
                child:  ElevatedButton(onPressed: () async {
                  if(controller.text.isNotEmpty){
                    final prefs = await SharedPreferences.getInstance();
                    SharedPreferenceService(prefs).addTodo(controller.text);
                    Navigator.pop(context);
                  }
                }, child: Text('Save',style: TextStyle(fontSize: 18),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
