import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  final String title;
  bool isDone;

  TodoItem({required this.id, required this.title, this.isDone = false});
}

enum FilterStatus { all, active, completed }

class TodoProvider extends ChangeNotifier {
  List<TodoItem> itemsList = [];
  FilterStatus filterStatus = FilterStatus.all;
  bool isDarkMode = false;

  List<TodoItem> get items {
    switch (filterStatus) {
      case FilterStatus.active:
        return itemsList.where((t) => !t.isDone).toList();
      case FilterStatus.completed:
        return itemsList.where((t) => t.isDone).toList();
      case FilterStatus.all:
        return itemsList;
    }
  }

  int get totalCount => itemsList.length;

  void addTask(String title) {
    if (title.trim().isEmpty) return;

    itemsList.insert(
      0,
      TodoItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    );
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = itemsList.indexWhere((t) => t.id == id);
    if (index == -1) return;

    itemsList[index].isDone = !itemsList[index].isDone;
    notifyListeners();
  }

  void deleteTask(String id) {
    itemsList.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void clearCompleted() {
    itemsList.removeWhere((t) => t.isDone);
    notifyListeners();
  }

  void changeFilter(FilterStatus status) {
    filterStatus = status;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
