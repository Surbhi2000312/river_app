import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/task/edit_task.dart';
import 'task_provider.dart'; // Import your provider
import 'add_data.dart'; // Import AddData

class ShowData extends ConsumerStatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends ConsumerState<ShowData> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await ref.read(taskProvider.notifier).loadTasks();
    setState(() {
      _isLoading = false; // Stop loading when data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Show Tasks')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? Center(child: Text('No tasks added yet.'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final taskDetail = tasks[index];
          return InkWell(
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  EditData(task:  taskDetail)));
            },
            child: ListTile(
              title: Text(taskDetail.name ?? 'No Name'),
              subtitle: Text('Date: ${taskDetail.date}, Time: ${taskDetail.time}'),
              trailing: taskDetail.isCompleted == true
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.radio_button_unchecked, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditData(task: taskDetail),
                  ),
                );
              },
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddData()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
