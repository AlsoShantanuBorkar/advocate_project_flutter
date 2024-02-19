import 'package:advocate_project_flutter/apis/task_apis/task_api.dart';
import 'package:advocate_project_flutter/models/task_model.dart';

class TasksRepository {
  const TasksRepository({
    required TaskAPI taskAPI,
  }) : _taskAPI = taskAPI;

  final TaskAPI _taskAPI;

  Stream<List<Task>> getTasks(String token) => _taskAPI.getTasks(token);

  Future<void> saveTask(Task task, String token) =>
      _taskAPI.saveTask(task, token);

  Future<void> deleteTask(String id, String token) =>
      _taskAPI.deleteTask(id, token);
}
