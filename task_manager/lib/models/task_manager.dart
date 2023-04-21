import 'package:task_manager/models/task.dart';

class TaskManager {
  List<Task> _tasks = [];

  void addTask(Task task) {
    _tasks.add(task);
  }

  List<Task> getTasks() {
    return _tasks;
  }
}
