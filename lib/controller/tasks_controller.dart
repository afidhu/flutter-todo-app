


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/task_model.dart';

Future<List<Task>> getAllTask() async {
  final prefs = await SharedPreferences.getInstance();

  List<String> tasksJson = prefs.getStringList('items') ?? [];

  return tasksJson.map((task) => Task.fromJson(jsonDecode(task))).toList();
}


Future<void> saveTasks(Task newTask) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> tasksJson = prefs.getStringList('items') ?? [];
  List<Task> tasks = tasksJson.map((task) => Task.fromJson(jsonDecode(task))).toList();
  tasks.add(newTask);
  List<String> updatedJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
  await prefs.setStringList('items', updatedJson);
  getAllTask();
}

Future<void> deleteTask(int index) async {
  final prefs = await SharedPreferences.getInstance();

  List<String> tasksJson = prefs.getStringList('items') ?? [];

  List<Task> tasks = tasksJson.map((item) => Task.fromJson(jsonDecode(item))).toList();

  tasks.removeAt(index);
  List<String> updatedJson = tasks.map((task) => jsonEncode(task.toJson())).toList();

  await prefs.setStringList('items', updatedJson);
}
