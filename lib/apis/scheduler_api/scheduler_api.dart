import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:advocate_project_flutter/apis/scheduler_api/scheduler_api_template.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ScheduleEventAPI extends AbstractSchedulerAPI {
  ScheduleEventAPI({
    required SharedPreferences sharedPreferencesIntsance,
  }) : _sharedPreferencesIntsance = sharedPreferencesIntsance {
    _init();
  }

  final SharedPreferences _sharedPreferencesIntsance;

  final BehaviorSubject<List<ScheduleEvent>> _eventStreamController =
      BehaviorSubject<List<ScheduleEvent>>.seeded(const []);

  static const _kScheduleEventsCollectionKey =
      '__scheduleModels_collection_key__';

  String? _getValue(String key) => _sharedPreferencesIntsance.getString(key);
  Future<void> _setValue(String key, String value) =>
      _sharedPreferencesIntsance.setString(key, value);

  void _init() {
    final String? eventsJson = _getValue(_kScheduleEventsCollectionKey);
    log(eventsJson.toString());
    if (eventsJson != null) {
      List x = jsonDecode(eventsJson);
      List<ScheduleEvent> events =
          x.map((e) => ScheduleEvent.fromJson(e)).toList();
      log(events.toString());
      _eventStreamController.add(events);
    } else {
      _eventStreamController.add(const []);
    }
  }

  @override
  Stream<List<ScheduleEvent>> getScheduleEvents(String token) {
    fetchScheduleEvents();
    return _eventStreamController.asBroadcastStream();
  }

  Future<void> fetchScheduleEvents() async {
    try {
      Uri uri = Uri.parse("");
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedResponse =
            (jsonDecode(response.body) as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
        final List<ScheduleEvent> events = [..._eventStreamController.value];
        decodedResponse.forEach((element) {
          ScheduleEvent eventModel = ScheduleEvent.fromMap(element);
          events.add(eventModel);
        });
        _eventStreamController.add(events);
        return _setValue(_kScheduleEventsCollectionKey, json.encode(events));
      } else {}
    } catch (e) {}
  }

  @override
  Future<void> saveScheduleEvent(ScheduleEvent eventModel, String token) {
    // try {
    //   Uri uri = Uri.parse("");
    //   http.Response response = await http.post(uri, body: eventModel.toJson());
    //   if (response.statusCode == 200) {
    //   } else {}
    // } catch (e) {}

    final List<ScheduleEvent> events = [..._eventStreamController.value];

    final eventModelIndex = events
        .indexWhere((t) => t.eventCaseNumber == eventModel.eventCaseNumber);
    if (eventModelIndex >= 0) {
      events[eventModelIndex] = eventModel;
    } else {
      events.add(eventModel);
    }

    _eventStreamController.add(events);
    return _setValue(_kScheduleEventsCollectionKey, json.encode(events));
  }

  @override
  Future<void> deleteScheduleEvent(String id, String token) async {
    // try {
    //   Uri uri = Uri.parse("");
    //   http.Response response = await http.delete(uri);
    //   if (response.statusCode == 200) {
    //   } else {}
    // } catch (e) {}

    final events = [..._eventStreamController.value];
    final eventModelIndex = events.indexWhere((t) => t.eventCaseNumber == id);
    if (eventModelIndex == -1) {
      throw ScheduleEventNotFoundException();
    } else {
      events.removeAt(eventModelIndex);
      _eventStreamController.add(events);
      return _setValue(_kScheduleEventsCollectionKey, json.encode(events));
    }
  }
}
