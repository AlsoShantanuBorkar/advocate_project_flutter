import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_state.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_events.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final String token;
  EditTaskBloc({
    required this.token,
    required TasksRepository tasksRepository,
    required Task? initialTask,
  })  : _tasksRepository = tasksRepository,
        super(EditTaskState(
          stateStatus: EditTaskStatus.initial,
          initialTask: initialTask,
          taskId: initialTask?.taskId ?? "",
          casePersonName: initialTask?.casePersonName ?? "",
          taskSubject: initialTask?.subject ?? "",
          taskDescription: initialTask?.taskDescription ?? "",
          taskStatus: initialTask?.status ?? TaskStatus.PENDING,
          assignedTo: initialTask?.assignedTo ?? "",
          relatedTo: initialTask?.relatedTo ?? "",
          caseNumber: initialTask?.caseNumber ?? "",
          startDate: initialTask?.startDate ?? DateTime.now(),
          taskPriority: initialTask?.priority ?? TaskPriority.LOW,
          deadline: initialTask?.deadline ?? DateTime.now(),
        )) {
    on<EditTaskDescriptionChanged>(_onTaskDescriptionChanged);

    on<EditTaskIdChanged>(_onTaskNumberChanged);

    on<EditTaskStatusChanged>(_onTaskStatusChanged);

    on<EditTaskSubjectChanged>(_onTaskSubjectChanged);

    on<EditTaskCasePersonNameChanged>(_onCasePersonNameChanged);

    on<EditTaskRelatedToChanged>(_onRelatedToChanged);

    on<EditTaskAssignedToChanged>(_onAssignedToChanged);

    on<EditTaskCaseNumberChanged>(_onCaseNumberChanged);

    on<EditTaskStartDateChanged>(_onStartDateChanged);

    on<EditTaskDeadlineChanged>(_onDeadlineChanged);

    on<EditTaskPriorityChanged>(_onTaskPriorityChanged);

    on<EditTaskSubmitted>(_onSubmitted);
  }

  final TasksRepository _tasksRepository;

  void _onTaskNumberChanged(
    EditTaskIdChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(taskId: event.taskId));
  }

  void _onTaskDescriptionChanged(
    EditTaskDescriptionChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(taskDescription: event.taskDescription));
  }

  void _onTaskStatusChanged(
    EditTaskStatusChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(taskStatus: event.taskStatus));
  }

  void _onTaskSubjectChanged(
    EditTaskSubjectChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(taskSubject: event.subject));
  }

  void _onCasePersonNameChanged(
    EditTaskCasePersonNameChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(casePersonName: event.casePersonName));
  }

  void _onRelatedToChanged(
    EditTaskRelatedToChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(relatedTo: event.relatedTo));
  }

  void _onAssignedToChanged(
    EditTaskAssignedToChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(assignedTo: event.assignedTo));
  }

  void _onCaseNumberChanged(
    EditTaskCaseNumberChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(caseNumber: event.caseNumber));
  }

  void _onStartDateChanged(
    EditTaskStartDateChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void _onDeadlineChanged(
    EditTaskDeadlineChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(deadline: event.deadline));
  }

  void _onTaskPriorityChanged(
    EditTaskPriorityChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(taskPriority: event.taskPriority));
  }

  void _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    emit(state.copyWith(stateStatus: EditTaskStatus.loading));
    final Task newTask = (state.initialTask ??
            Task(
              taskId: '',
              startDate: DateTime.now(),
              deadline: DateTime.now(),
            ))
        .copyWith(
      taskId: state.taskId,
      casePersonName: state.casePersonName,
      taskDescription: state.taskDescription,
      status: state.taskStatus,
      subject: state.taskSubject,
      startDate: state.startDate,
      priority: state.taskPriority,
      deadline: state.deadline,
      assignedTo: state.assignedTo,
      relatedTo: state.relatedTo,
      caseNumber: state.caseNumber,
    );
    try {
      if (state.initialTask != null) {
        await _tasksRepository.deleteTask(state.initialTask!.taskId, token);
      }
      await _tasksRepository.saveTask(newTask, token);
      emit(state.copyWith(stateStatus: EditTaskStatus.success));
    } catch (e) {
      emit(state.copyWith(stateStatus: EditTaskStatus.failure));
    }
  }
}
