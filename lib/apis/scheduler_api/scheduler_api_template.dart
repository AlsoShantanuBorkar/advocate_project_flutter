import 'package:advocate_project_flutter/models/scheduler_event_model.dart';

abstract class AbstractSchedulerAPI {
  const AbstractSchedulerAPI();

  Stream<List<ScheduleEvent>> getScheduleEvents(String token);

  Future<void> saveScheduleEvent(ScheduleEvent event, String token);

  Future<void> deleteScheduleEvent(String id, String token);
}

class ScheduleEventNotFoundException implements Exception {}
