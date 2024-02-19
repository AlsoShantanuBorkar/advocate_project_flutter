import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:advocate_project_flutter/apis/API_ROUTES.dart';
import 'package:advocate_project_flutter/apis/task_apis/task_api_template.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskAPI extends AbstractTaskAPI {
  final Dio dio = Dio();
  TaskAPI({
    required SharedPreferences sharedPreferencesIntsance,
  }) : _sharedPreferencesIntsance = sharedPreferencesIntsance {
    _init();
  }

  final SharedPreferences _sharedPreferencesIntsance;

  final BehaviorSubject<List<Task>> _taskStreamController =
      BehaviorSubject<List<Task>>.seeded(const []);

  static const _kTasksCollectionKey = '__taskModels_collection_key__';

  String? _getValue(String key) => _sharedPreferencesIntsance.getString(key);
  Future<void> _setValue(String key, String value) =>
      _sharedPreferencesIntsance.setString(key, value);

  void _init() {
    final String? tasksJson = _getValue(_kTasksCollectionKey);

    if (tasksJson != null) {
      List x = jsonDecode(tasksJson);
      List<Task> tasks = x.map((e) => Task.fromJson(e)).toList();
      _taskStreamController.add(tasks);
    } else {
      _taskStreamController.add(const []);
    }
  }

  @override
  Stream<List<Task>> getTasks(String token) {
    fetchTasks(token);
    return _taskStreamController.asBroadcastStream();
  }

  Future<void> fetchTasks(String token) async {
    try {
      Uri uri = Uri.parse(API_ROUTES.getTasks);
      http.Response response = await http.get(uri, headers: {"token": token});
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedResponse =
            (jsonDecode(response.body) as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
        final List<Task> tasks = [..._taskStreamController.value];
        decodedResponse.forEach((element) {
          Task taskModel = Task.fromMap(element);
          int index = tasks.indexWhere(
              (element) => element.caseNumber == taskModel.caseNumber);
          if (index != -1) {
            tasks[index] = taskModel;
          } else {
            tasks.add(taskModel);
          }
        });
        _taskStreamController.add(tasks);
        return _setValue(_kTasksCollectionKey, json.encode(tasks));
      } else {
        log(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> saveTask(Task taskModel, String token) async {
    try {
      Uri uri = Uri.parse(API_ROUTES.putTasks);

      final Response response = await dio.postUri(
        uri,
        data: jsonEncode(taskModel.toMap()),
        options: Options(
            headers: {"token": token, 'content-type': 'application/json'}),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        final List<Task> tasks = [..._taskStreamController.value];

        final taskModelIndex =
            tasks.indexWhere((t) => t.taskId == taskModel.taskId);
        if (taskModelIndex >= 0) {
          tasks[taskModelIndex] = taskModel;
        } else {
          tasks.add(taskModel);
        }

        _taskStreamController.add(tasks);
        _setValue(_kTasksCollectionKey, json.encode(tasks));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTask(String id, String token) async {
    try {
      final tasks = [..._taskStreamController.value];
      final taskModelIndex = tasks.indexWhere((t) => t.taskId == id);
      if (taskModelIndex == -1) {
        return false;
      } else {
        Uri uri = Uri.parse("");
        http.Response response =
            await http.delete(uri, headers: {"token": token});
        if (response.statusCode == 200) {
          tasks.removeAt(taskModelIndex);
          _taskStreamController.add(tasks);
          _setValue(_kTasksCollectionKey, json.encode(tasks));
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }
}
