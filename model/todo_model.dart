import 'package:flutter/material.dart';

class Todo{
  final String Title;
  final String Desc;
  const Todo(this.Title, this.Desc);
}

class TodoProvider extends ChangeNotifier {
  Todo? selectedTodo;

  void selectTodo(Todo todo) {
    selectedTodo = todo;
    notifyListeners();
  }
}
