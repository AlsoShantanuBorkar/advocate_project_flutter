import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:equatable/equatable.dart';

abstract class ScheduleListEvent extends Equatable {}

class SchedulesListSubscriptionRequstedEvent extends ScheduleListEvent {
  SchedulesListSubscriptionRequstedEvent();

  @override
  List<Object> get props => [];
}

class SchedulesListDeleteScheduleEvent extends ScheduleListEvent {
  SchedulesListDeleteScheduleEvent({required this.scheduleEvent});

  final ScheduleEvent scheduleEvent;

  @override
  List<Object> get props => [scheduleEvent];
}

class SchedulesListUndoDeleteScheduleEvent extends ScheduleListEvent {
  SchedulesListUndoDeleteScheduleEvent();

  @override
  List<Object> get props => [];
}
