import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:equatable/equatable.dart';

abstract class TaskListEvent extends Equatable {}

class TasksListSubscriptionRequstedEvent extends TaskListEvent {
  TasksListSubscriptionRequstedEvent();

  @override
  List<Object> get props => [];
}

class TasksListDeleteTaskEvent extends TaskListEvent {
  TasksListDeleteTaskEvent({required this.taskModel});

  final Task taskModel;

  @override
  List<Object> get props => [taskModel];
}

class TasksListUndoDeleteTaskEvent extends TaskListEvent {
  TasksListUndoDeleteTaskEvent();

  @override
  List<Object> get props => [];
}

class TasksListChangeTaskFilterEvent extends TaskListEvent {
  TasksListChangeTaskFilterEvent({required this.taskModelListFilter});

  final TaskListFilter taskModelListFilter;

  @override
  List<Object> get props => [];
}
