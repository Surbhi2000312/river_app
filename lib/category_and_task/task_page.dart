import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/category_and_task/add_task_page.dart';

import '../json/category.dart';
import '../provider/category.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {

  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: DropdownButton<Category>(
          value: selectedCategory,
          items: ref.watch(categoryProvider).map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name ?? 'Unknown'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        )
        ,
      ),

      

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskPage()),
        );
      },child: Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}
