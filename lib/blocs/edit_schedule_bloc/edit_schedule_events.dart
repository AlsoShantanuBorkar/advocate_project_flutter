import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class EditScheduleEvent extends Equatable {
  const EditScheduleEvent();

  @override
  List<Object?> get props => [];
}

final class EditScheduleCaseNumberChanged extends EditScheduleEvent {
  const EditScheduleCaseNumberChanged(this.eventCaseNumber);

  final String eventCaseNumber;

  @override
  List<Object> get props => [eventCaseNumber];
}

final class EditScheduleNoteChanged extends EditScheduleEvent {
  const EditScheduleNoteChanged(this.eventCaseNote);

  final String eventCaseNote;

  @override
  List<Object> get props => [eventCaseNote];
}

final class EditScheduleEventDateChanged extends EditScheduleEvent {
  const EditScheduleEventDateChanged(this.eventDate);

  final DateTime eventDate;

  @override
  List<Object> get props => [eventDate];
}

final class EditScheduleEventTimeChanged extends EditScheduleEvent {
  const EditScheduleEventTimeChanged(this.eventTime);

  final TimeOfDay eventTime;

  @override
  List<Object> get props => [eventTime];
}

final class EditScheduleSubmitted extends EditScheduleEvent {
  const EditScheduleSubmitted();

  @override
  List<Object?> get props => [];
}
