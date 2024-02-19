import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:equatable/equatable.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object?> get props => [];
}

final class EditTaskIdChanged extends EditTaskEvent {
  const EditTaskIdChanged(this.taskId);

  final String taskId;

  @override
  List<Object> get props => [taskId];
}

final class EditTaskDescriptionChanged extends EditTaskEvent {
  const EditTaskDescriptionChanged(this.taskDescription);

  final String taskDescription;

  @override
  List<Object> get props => [taskDescription];
}

final class EditTaskCasePersonNameChanged extends EditTaskEvent {
  const EditTaskCasePersonNameChanged(this.casePersonName);

  final String casePersonName;

  @override
  List<Object> get props => [casePersonName];
}

final class EditTaskSubjectChanged extends EditTaskEvent {
  const EditTaskSubjectChanged(this.subject);

  final String subject;

  @override
  List<Object> get props => [subject];
}

final class EditTaskStatusChanged extends EditTaskEvent {
  const EditTaskStatusChanged(this.taskStatus);

  final TaskStatus taskStatus;

  @override
  List<Object> get props => [taskStatus];
}

final class EditTaskCaseNumberChanged extends EditTaskEvent {
  const EditTaskCaseNumberChanged(this.caseNumber);

  final String caseNumber;

  @override
  List<Object> get props => [caseNumber];
}

final class EditTaskStartDateChanged extends EditTaskEvent {
  const EditTaskStartDateChanged(this.startDate);

  final DateTime startDate;

  @override
  List<Object> get props => [startDate];
}

final class EditTaskDeadlineChanged extends EditTaskEvent {
  const EditTaskDeadlineChanged(this.deadline);

  final DateTime deadline;

  @override
  List<Object> get props => [deadline];
}

final class EditTaskAssignedToChanged extends EditTaskEvent {
  const EditTaskAssignedToChanged(this.assignedTo);

  final String assignedTo;

  @override
  List<Object> get props => [assignedTo];
}

final class EditTaskRelatedToChanged extends EditTaskEvent {
  const EditTaskRelatedToChanged(this.relatedTo);

  final String relatedTo;

  @override
  List<Object> get props => [relatedTo];
}

final class EditTaskPriorityChanged extends EditTaskEvent {
  const EditTaskPriorityChanged(this.taskPriority);

  final TaskPriority taskPriority;

  @override
  List<Object> get props => [taskPriority];
}

final class EditTaskSubmitted extends EditTaskEvent {
  const EditTaskSubmitted();

  @override
  List<Object> get props => [];
}
