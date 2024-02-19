import 'package:advocate_project_flutter/apis/scheduler_api/scheduler_api.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';

class ScheduleEventRepository {
  const ScheduleEventRepository({
    required ScheduleEventAPI scheduleEventAPI,
  }) : _scheduleEventAPI = scheduleEventAPI;

  final ScheduleEventAPI _scheduleEventAPI;

  Stream<List<ScheduleEvent>> getScheduleEvents(String token) =>
      _scheduleEventAPI.getScheduleEvents(token);

  Future<void> saveScheduleEvent(ScheduleEvent event, String token) =>
      _scheduleEventAPI.saveScheduleEvent(event, token);

  Future<void> deleteScheduleEvent(String id, String token) =>
      _scheduleEventAPI.deleteScheduleEvent(id, token);
}
