import 'package:advocate_project_flutter/blocs/task_list_bloc/task_list_events.dart';
import 'package:advocate_project_flutter/blocs/task_list_bloc/task_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final String token;
  final TasksRepository _tasksRepository;

  TaskListBloc({required this.token, required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository,
        super(const TaskListState()) {
    on<TasksListSubscriptionRequstedEvent>(
        _onTasksListSubscriptionRequstedEvent);
    on<TasksListDeleteTaskEvent>(_onTasksListDeleteTaskEvent);
    on<TasksListUndoDeleteTaskEvent>(_onTasksListUndoDeleteTask);
    on<TasksListChangeTaskFilterEvent>(_onTasksListChangeTaskFilter);
  }

  Future<void> _onTasksListSubscriptionRequstedEvent(
    TasksListSubscriptionRequstedEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(taskListStatus: TaskListStatus.init));

    await emit.forEach<List<Task>>(
      _tasksRepository.getTasks(token),
      onData: (taskModelList) => state.copyWith(
        taskListStatus: TaskListStatus.success,
        taskList: taskModelList,
      ),
      onError: (_, __) => state.copyWith(
        taskListStatus: TaskListStatus.failure,
      ),
    );
  }

  Future<void> _onTasksListDeleteTaskEvent(
    TasksListDeleteTaskEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTask: event.taskModel));
    await _tasksRepository.deleteTask(event.taskModel.taskId, token);
  }

  Future<void> _onTasksListUndoDeleteTask(
    TasksListUndoDeleteTaskEvent event,
    Emitter<TaskListState> emit,
  ) async {
    assert(
      state.lastDeletedTask != null,
      'Last deleted task can not be null.',
    );

    final task = state.lastDeletedTask!;
    emit(state.copyWith(lastDeletedTask: null));
    await _tasksRepository.saveTask(task, token);
  }

  Future<void> _onTasksListChangeTaskFilter(
    TasksListChangeTaskFilterEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(taskListFilter: event.taskModelListFilter));
  }
}
