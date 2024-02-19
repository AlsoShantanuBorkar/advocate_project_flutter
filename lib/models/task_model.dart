// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:advocate_project_flutter/constants/enums/task_enums.dart';

@immutable
class Task extends Equatable {
  String? id;
  String taskId;
  String subject;
  final DateTime startDate;
  final DateTime deadline;
  TaskStatus status;
  TaskPriority priority;
  String assignedTo;
  String relatedTo;
  String casePersonName;
  String caseNumber;
  String taskDescription;
  Task({
    String? id,
    this.taskId = "",
    this.subject = "",
    required this.startDate,
    required this.deadline,
    this.status = TaskStatus.PENDING,
    this.priority = TaskPriority.LOW,
    this.assignedTo = "",
    this.relatedTo = "",
    this.casePersonName = "",
    this.caseNumber = "",
    this.taskDescription = "",
  })  : assert(
          id == null || id.isNotEmpty,
          'taskId must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  @override
  List<Object> get props {
    return [
      taskId,
      subject,
      startDate,
      deadline,
      status,
      priority,
      assignedTo,
      relatedTo,
      casePersonName,
      caseNumber,
      taskDescription,
    ];
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'taskId': taskId});
    result.addAll({'subject': subject});
    result.addAll({'startDate': startDate.toIso8601String()});
    result.addAll({'deadline': deadline.toIso8601String()});
    result.addAll({'status': status.name});
    result.addAll({'priority': priority.name});
    result.addAll({'assignedTo': assignedTo});
    result.addAll({'relatedTo': relatedTo});
    result.addAll({'casePersonName': casePersonName});
    result.addAll({'caseNumber': caseNumber});
    result.addAll({'taskDescription': taskDescription});

    return result;
  }
  //   "taskId": "TASK123",
  // "subject": "Meeting preparation",
  // "startDate": "2023-01-15T09:00:00.000Z",
  // "deadline": "2023-01-20T17:00:00.000Z",
  // "status": "OPEN",
  // "priority": "MEDIUM",
  // "assignedTo": "John Doe",
  // "relatedTo": "Client Meeting",
  // "casePersonName": "Client ABC",
  // "caseNumber": "CASE456",
  // "taskDescription": "Prepare documents and agenda for the client meeting."

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskId: map['taskId'] ?? '',
      subject: map['subject'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      deadline: DateTime.parse(map['deadline']),
      status: TaskStatus.values
          .firstWhere((element) => element.name == map["status"]),
      priority: TaskPriority.values
          .firstWhere((element) => element.name == map["priority"]),
      assignedTo: map['assignedTo'] ?? '',
      relatedTo: map['relatedTo'] ?? '',
      casePersonName: map['casePersonName'] ?? '',
      caseNumber: map['caseNumber'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  Task copyWith({
    String? id,
    String? taskId,
    String? subject,
    DateTime? startDate,
    DateTime? deadline,
    TaskStatus? status,
    TaskPriority? priority,
    String? assignedTo,
    String? relatedTo,
    String? casePersonName,
    String? caseNumber,
    String? taskDescription,
  }) {
    return Task(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      subject: subject ?? this.subject,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      relatedTo: relatedTo ?? this.relatedTo,
      casePersonName: casePersonName ?? this.casePersonName,
      caseNumber: caseNumber ?? this.caseNumber,
      taskDescription: taskDescription ?? this.taskDescription,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, taskId: $taskId, subject: $subject, startDate: $startDate, deadline: $deadline, status: $status, priority: $priority, assignedTo: $assignedTo, relatedTo: $relatedTo, casePersonName: $casePersonName, caseNumber: $caseNumber, taskDescription: $taskDescription)';
  }
}
