import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:equatable/equatable.dart';

class TaskListState extends Equatable {
  const TaskListState({
    this.taskListStatus = TaskListStatus.init,
    this.taskList = const [],
    this.taskListFilter = TaskListFilter.ALL,
    this.lastDeletedTask,
  });

  final TaskListStatus taskListStatus;
  final List<Task> taskList;
  final TaskListFilter taskListFilter;
  final Task? lastDeletedTask;

  Iterable<Task> get filteredTasks {
    if (taskListFilter == TaskListFilter.ALL) {
      return taskList;
    } else if (taskListFilter == TaskListFilter.OPEN) {
      return taskList.where((element) => element.status == TaskStatus.PENDING);
    } else if (taskListFilter == TaskListFilter.OPEN) {
      return taskList.where((element) => element.status == TaskStatus.OPEN);
    } else {
      return taskList.where((element) => element.status == TaskStatus.INACTIVE);
    }
  }

  TaskListState copyWith({
    TaskListStatus? taskListStatus,
    List<Task>? taskList,
    TaskListFilter? taskListFilter,
    Task? lastDeletedTask,
  }) {
    return TaskListState(
      taskListStatus: taskListStatus ?? this.taskListStatus,
      taskList: taskList ?? this.taskList,
      taskListFilter: taskListFilter ?? this.taskListFilter,
      lastDeletedTask: lastDeletedTask ?? this.lastDeletedTask,
    );
  }

  @override
  List<Object?> get props =>
      [taskListStatus, taskList, taskListFilter, lastDeletedTask];
}
