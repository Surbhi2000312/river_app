import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/json/Task.dart';
import 'task_provider.dart'; // Import your provider
 // Import your Task model

class AddData extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController isCompletedController = TextEditingController();

  AddData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);

    void _submitTask() {
      final task = Task(
        id: DateTime.now().toIso8601String(),
        name: nameController.text,
        date: dateController.text,
        time: timeController.text,
        isCompleted: 'false',
      );

      taskNotifier.addTask(task);
      Navigator.pop(context); // Navigate back to the ShowData screen
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  dateController.text = selectedDate.toIso8601String().split('T').first;
                }
              },
              readOnly: true,
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time (HH:MM AM/PM)'),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  timeController.text = selectedTime.format(context);
                }
              },
              readOnly: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitTask,
              child: Text('Submit Task'),
            ),
          ],
        ),
      ),
    );
  }
}
