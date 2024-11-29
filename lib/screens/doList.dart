import 'package:flutter/material.dart';
import '../shared/task_manager.dart';

class doList extends StatefulWidget {
  @override
  _DoListState createState() => _DoListState();
}

class _DoListState extends State<doList> {
  String _selectedCategory = 'Default';
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  // Add a New Category
  void _addCategory() {
    if (_categoryController.text.isNotEmpty) {
      TaskManager.addCategory(_categoryController.text);
      _categoryController.clear();
      setState(() {}); // Update the UI
    }
  }

  // Add a Task to the Selected Category
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      TaskManager.addTask(_selectedCategory, _taskController.text);
      _taskController.clear();
      setState(() {}); // Update the UI
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Do List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Category Dropdown and Add Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    items: TaskManager.categories.keys
                        .map<DropdownMenuItem<String>>(
                          (String category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Add Category'),
                        content: TextField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _addCategory();
                              Navigator.pop(context);
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Add Task
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Add New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // Task List for Selected Category
          Expanded(
            child: ListView.builder(
              itemCount: TaskManager.categories[_selectedCategory]?.length ?? 0,
              itemBuilder: (context, index) {
                final task = TaskManager.categories[_selectedCategory]![index];
                return ListTile(
                  title: Text(task),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      TaskManager.moveTaskToDone(
                          _selectedCategory, task); // Pass category and task
                      setState(() {}); // Update the UI
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
