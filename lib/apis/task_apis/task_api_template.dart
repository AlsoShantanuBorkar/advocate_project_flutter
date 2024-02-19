import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/models/task_model.dart';

abstract class AbstractTaskAPI {
  const AbstractTaskAPI();

  Stream<List<Task>> getTasks(String token);

  Future<bool> saveTask(Task taskModel, String token);

  Future<void> deleteTask(String id, String token);
}

class TaskNotFoundException implements Exception {}
