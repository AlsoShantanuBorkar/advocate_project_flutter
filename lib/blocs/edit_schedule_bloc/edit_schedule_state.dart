// ignore_for_file: non_constant_identifier_names

import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EditScheduleEventState extends Equatable {
  final EditScheduleEventStatus stateStatus;
  final ScheduleEvent? initialScheduleEvent;
  final String eventCaseNumber;
  final String eventCaseNote;
  final DateTime eventDate;
  final TimeOfDay eventTime;

  const EditScheduleEventState(
      {this.stateStatus = EditScheduleEventStatus.initial,
      this.initialScheduleEvent,
      required this.eventCaseNumber,
      required this.eventCaseNote,
      required this.eventDate,
      required this.eventTime});

  bool get isNewScheduleEvent => initialScheduleEvent == null;

  @override
  // TODO: implement props
  List<Object?> get props => [
        stateStatus,
        initialScheduleEvent,
        eventCaseNumber,
        eventCaseNote,
        eventDate,
        eventTime,
      ];

  EditScheduleEventState copyWith({
    EditScheduleEventStatus? stateStatus,
    ScheduleEvent? initialScheduleEvent,
    String? eventCaseNumber,
    String? eventCaseNote,
    DateTime? eventDate,
    TimeOfDay? eventTime,
  }) {
    return EditScheduleEventState(
      stateStatus: stateStatus ?? this.stateStatus,
      initialScheduleEvent: initialScheduleEvent ?? this.initialScheduleEvent,
      eventCaseNumber: eventCaseNumber ?? this.eventCaseNumber,
      eventCaseNote: eventCaseNote ?? this.eventCaseNote,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
    );
  }
}
