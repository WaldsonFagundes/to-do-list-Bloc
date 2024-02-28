import 'dart:async';

import 'package:to_do_list/model/task.dart';

class TaskBloc {

  final _tasksController = StreamController<List<Task>>.broadcast();
  List<Task> tasks = [];

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  void addTask(Task task) {
    tasks.add(task);
    _tasksController.add(tasks);
  }

  void toggleTaskStatus(int taskId){
    tasks.firstWhere((task) => task.id == taskId).completed = !tasks.firstWhere((task) => task.id == taskId).completed;
    _tasksController.add(tasks);
  }
  void removeTask(int taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    _tasksController.add(tasks);
  }

  void dispose() {
    _tasksController.close();
  }

}