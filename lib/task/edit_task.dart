import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../json/Task.dart';
import 'task_provider.dart'; // Import your provider
  // Import Task model

class EditData extends ConsumerStatefulWidget {
  final Task task; // Task to be edited

  const EditData({Key? key, required this.task}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends ConsumerState<EditData> {
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current task values
    _nameController = TextEditingController(text: widget.task.name);
    _dateController = TextEditingController(text: widget.task.date);
    _timeController = TextEditingController(text: widget.task.time);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _updateTask() async {
    // Update the task with new values
    final updatedTask = widget.task.copyWith(
      name: _nameController.text,
      date: _dateController.text,
      time: _timeController.text,
    );


    // Update the task in the provider
    await ref.read(taskProvider.notifier).updateTask(updatedTask);

    // Navigate back to ShowData
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateTask,
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}


