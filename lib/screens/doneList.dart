import 'package:flutter/material.dart';
import '../shared/task_manager.dart';

class doneList extends StatefulWidget {
  @override
  _DoneListState createState() => _DoneListState();
}

class _DoneListState extends State<doneList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: TaskManager.categories['Done']?.length ?? 0,
        itemBuilder: (context, index) {
          final task = TaskManager.categories['Done']![index];
          return ListTile(
            title: Text(task),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                TaskManager.deleteTask('Done', task); // Delete from "Done"
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
