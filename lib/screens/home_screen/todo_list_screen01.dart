import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem() {
    setState(() {
      int index = _todoItems.length;
      _todoItems.add('Item ' + index.toString());
    });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
        return Offstage();
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return new ListTile(title: new Text(todoText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        elevation: 0.0,
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
      ),
    );
  }
}
