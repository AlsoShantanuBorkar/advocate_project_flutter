import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:equatable/equatable.dart';

class ScheduleListEventState extends Equatable {
  const ScheduleListEventState({
    this.eventListStatus = ScheduleEventListStateStatus.initial,
    this.eventList = const [],
    this.lastDeletedScheduleEvent,
  });

  final ScheduleEventListStateStatus eventListStatus;
  final List<ScheduleEvent> eventList;
  final ScheduleEvent? lastDeletedScheduleEvent;

  ScheduleListEventState copyWith({
    ScheduleEventListStateStatus? eventListStatus,
    List<ScheduleEvent>? eventList,
    ScheduleEvent? lastDeletedScheduleEvent,
  }) {
    return ScheduleListEventState(
      eventListStatus: eventListStatus ?? this.eventListStatus,
      eventList: eventList ?? this.eventList,
      lastDeletedScheduleEvent:
          lastDeletedScheduleEvent ?? this.lastDeletedScheduleEvent,
    );
  }

  @override
  List<Object?> get props =>
      [eventListStatus, eventList, lastDeletedScheduleEvent];
}
