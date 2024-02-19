// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';

class EditTaskState extends Equatable {
  final EditTaskStatus stateStatus;
  final Task? initialTask;
  final String taskId;
  final String taskDescription;
  final TaskStatus taskStatus;
  final String taskSubject;
  final DateTime startDate;
  final DateTime deadline;
  final TaskPriority taskPriority;
  final String assignedTo;
  final String relatedTo;
  final String casePersonName;
  final String caseNumber;

  const EditTaskState(
      {required this.stateStatus,
      required this.initialTask,
      required this.taskId,
      required this.taskDescription,
      required this.taskStatus,
      required this.taskSubject,
      required this.startDate,
      required this.deadline,
      required this.taskPriority,
      required this.assignedTo,
      required this.relatedTo,
      required this.casePersonName,
      required this.caseNumber});

  EditTaskState copyWith({
    EditTaskStatus? stateStatus,
    Task? initialTask,
    String? taskId,
    String? taskDescription,
    TaskStatus? taskStatus,
    String? taskSubject,
    DateTime? startDate,
    DateTime? deadline,
    TaskPriority? taskPriority,
    String? assignedTo,
    String? relatedTo,
    String? casePersonName,
    String? caseNumber,
  }) {
    return EditTaskState(
      stateStatus: stateStatus ?? this.stateStatus,
      initialTask: initialTask ?? this.initialTask,
      taskId: taskId ?? this.taskId,
      taskDescription: taskDescription ?? this.taskDescription,
      taskStatus: taskStatus ?? this.taskStatus,
      taskSubject: taskSubject ?? this.taskSubject,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      taskPriority: taskPriority ?? this.taskPriority,
      assignedTo: assignedTo ?? this.assignedTo,
      relatedTo: relatedTo ?? this.relatedTo,
      casePersonName: casePersonName ?? this.casePersonName,
      caseNumber: caseNumber ?? this.caseNumber,
    );
  }

  bool get isNewTask => initialTask == null;

  @override
  List<Object> get props {
    return [
      stateStatus,
      taskId,
      taskDescription,
      taskStatus,
      taskSubject,
      startDate,
      deadline,
      taskPriority,
      assignedTo,
      relatedTo,
      casePersonName,
      caseNumber,
    ];
  }
}
