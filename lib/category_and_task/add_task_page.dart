import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/provider/category.dart';
import 'package:river_app/widget_helper/text_widget.dart';

import '../json/category.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<AddTaskPage> {
  Category? selectedCategory;
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: getBlackColor(text: 'New task'),),

      body: Center(
        child: Row(
          children: [
            Expanded(
              child: DropdownButton<Category>(
                icon: Icon(Icons.arrow_circle_down_sharp,color: Colors.white,),
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
              ),
            )

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){

      },child: Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}
void showAddCategoryDialog(BuildContext context, WidgetRef ref) {
  TextEditingController categoryController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add New Category'),
        content: TextField(controller: categoryController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (categoryController.text.isNotEmpty) {
                ref.read(categoryProvider.notifier).addCategory(
                  Category(name: categoryController.text, length: '0', dueLength: '0'),
                );
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
