// Build a to-do list app using Hive or SQLite with functionality to add, update, delete, and view tasks.

import 'package:flutter/material.dart';

import 'dbHelper.dart';

void main() {
  runApp(MaterialApp(home: ToDoApp(), debugShowCheckedModeBanner: false,));
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final DBHelper _dbHelper = DBHelper.instance;
  late List<Map<String, dynamic>> _tasks = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshTasks();
  }

  _refreshTasks() async {
    final data = await _dbHelper.queryAllTasks();
    setState(() {
      _tasks = data;
    });
  }

  _showForm(int? id) {
    if (id != null) {
      final existingTask = _tasks.firstWhere((element) => element['id'] == id);
      _titleController.text = existingTask['title'];
      _descController.text = existingTask['description'];
    } else {
      _titleController.clear();
      _descController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(id == null ? "Add Task" : "Edit Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title"
              )
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: "Description"
              )
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (id == null) {
                await _dbHelper.insertTask({
                  "title": _titleController.text,
                  "description": _descController.text,
                  "status": 0,
                });
              } else {
                await _dbHelper.updateTask({
                  "id": id,
                  "title": _titleController.text,
                  "description": _descController.text,
                });
              }
              _refreshTasks();
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  _deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List"),),
      body: _tasks.isEmpty ? Center(child: Text("No tasks yet.")) : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(_tasks[index]['title']),
            subtitle: Text(_tasks[index]['description']),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showForm(_tasks[index]['id'])
                ),
                IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteTask(_tasks[index]['id'])),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
