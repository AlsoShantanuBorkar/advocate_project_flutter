import 'dart:convert';

import 'package:advocate_project_flutter/constants/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ScheduleEvent extends Equatable {
  final String eventCaseNumber;
  final DateTime eventDate;
  final String eventCaseNote;
  final TimeOfDay eventTime;
  const ScheduleEvent({
    required this.eventCaseNumber,
    required this.eventDate,
    required this.eventCaseNote,
    required this.eventTime,
  });

  @override
  List<Object> get props =>
      [eventCaseNumber, eventDate, eventCaseNote, eventTime];

  ScheduleEvent copyWith({
    String? eventCaseNumber,
    DateTime? eventDate,
    String? eventCaseNote,
    TimeOfDay? eventTime,
  }) {
    return ScheduleEvent(
      eventCaseNumber: eventCaseNumber ?? this.eventCaseNumber,
      eventDate: eventDate ?? this.eventDate,
      eventCaseNote: eventCaseNote ?? this.eventCaseNote,
      eventTime: eventTime ?? this.eventTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'eventCaseNumber': eventCaseNumber});
    result.addAll({'eventDate': eventDate.toIso8601String()});
    result.addAll({'eventCaseNote': eventCaseNote});
    result
        .addAll({'eventTime': eventDate.applied(eventTime).toIso8601String()});

    return result;
  }

  factory ScheduleEvent.fromMap(Map<String, dynamic> map) {
    return ScheduleEvent(
        eventCaseNumber: map['eventCaseNumber'] ?? '',
        eventDate: DateTime.parse(map['eventDate']),
        eventCaseNote: map['eventCaseNote'] ?? '',
        eventTime: TimeOfDay.fromDateTime(
          DateTime.parse(map['eventTime']),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ScheduleEvent.fromJson(String source) =>
      ScheduleEvent.fromMap(json.decode(source));
}
