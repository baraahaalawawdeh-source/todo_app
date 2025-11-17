import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  final String title;
  bool isDone;

  TodoItem({required this.id, required this.title, this.isDone = false});
}

enum FilterStatus { all, active, completed }

class TodoProvider extends ChangeNotifier {
  final List<TodoItem> allItems = [];
  FilterStatus currentFilter = FilterStatus.all;
  bool isDarkMode = false;

  List<TodoItem> get items {
    switch (currentFilter) {
      case FilterStatus.active:
        return allItems.where((t) => !t.isDone).toList();
      case FilterStatus.completed:
        return allItems.where((t) => t.isDone).toList();
      case FilterStatus.all:
        return allItems;
    }
  }

  int get totalCount => allItems.length;
  FilterStatus get filter => currentFilter;

  void addTask(String title) {
    if (title.trim().isEmpty) return;

    allItems.insert(
      0,
      TodoItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    );
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = allItems.indexWhere((t) => t.id == id);
    if (index == -1) return;

    allItems[index].isDone = !allItems[index].isDone;
    notifyListeners();
  }

  void deleteTask(String id) {
    allItems.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void clearCompleted() {
    allItems.removeWhere((t) => t.isDone);
    notifyListeners();
  }

  void changeFilter(FilterStatus status) {
    currentFilter = status;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
