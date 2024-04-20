import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List to store our to-do items
  List<TodoItem> _todoList = [];

  // Function to add a new to-do item
  void _addNewTodo(String newTodo) {
    setState(() {
      _todoList.add(TodoItem(title: newTodo, isCompleted: false));
    });
  }

  // Function to toggle the completion status of a to-do item
  void _toggleTodo(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
  }

  // Function to remove a to-do item
  void _removeTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text field to enter a new to-do item
              TextField(
                onSubmitted: (String newTodo) {
                  _addNewTodo(newTodo);
                },
                decoration: const InputDecoration(
                  hintText: 'Add a new item...',
                ),
              ),
              // List view to display existing to-do items
              Expanded(
                child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _todoList[index].title,
                        style: TextStyle(
                          decoration: _todoList[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _todoList[index].isCompleted,
                            onChanged: (bool? value) {
                              _toggleTodo(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeTodo(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem {
  final String title;
  bool isCompleted;

  TodoItem({required this.title, required this.isCompleted});
}