import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_events.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleEventListBloc
    extends Bloc<ScheduleListEvent, ScheduleListEventState> {
  final ScheduleEventRepository _eventsRepository;
  final String token;
  ScheduleEventListBloc(
      {required ScheduleEventRepository eventsRepository, required this.token})
      : _eventsRepository = eventsRepository,
        super(const ScheduleListEventState()) {
    on<SchedulesListSubscriptionRequstedEvent>(
        _onScheduleEventsListSubscriptionRequstedEvent);
    on<SchedulesListDeleteScheduleEvent>(_onSchedulesListDeleteScheduleEvent);
    on<SchedulesListUndoDeleteScheduleEvent>(
        _onSchedulesListUndoDeleteScheduleEvent);
  }

  Future<void> _onScheduleEventsListSubscriptionRequstedEvent(
    SchedulesListSubscriptionRequstedEvent event,
    Emitter<ScheduleListEventState> emit,
  ) async {
    emit(state.copyWith(eventListStatus: ScheduleEventListStateStatus.initial));

    await emit.forEach<List<ScheduleEvent>>(
      _eventsRepository.getScheduleEvents(
        token,
      ),
      onData: (eventList) => state.copyWith(
        eventListStatus: ScheduleEventListStateStatus.success,
        eventList: eventList,
      ),
      onError: (_, __) => state.copyWith(
        eventListStatus: ScheduleEventListStateStatus.failure,
      ),
    );
  }

  Future<void> _onSchedulesListDeleteScheduleEvent(
    SchedulesListDeleteScheduleEvent event,
    Emitter<ScheduleListEventState> emit,
  ) async {
    emit(state.copyWith(lastDeletedScheduleEvent: event.scheduleEvent));
    await _eventsRepository.deleteScheduleEvent(
        token, event.scheduleEvent.eventCaseNumber);
  }

  Future<void> _onSchedulesListUndoDeleteScheduleEvent(
    SchedulesListUndoDeleteScheduleEvent event,
    Emitter<ScheduleListEventState> emit,
  ) async {
    assert(
      state.lastDeletedScheduleEvent != null,
      'Last deleted todo can not be null.',
    );

    final event = state.lastDeletedScheduleEvent!;
    emit(state.copyWith(lastDeletedScheduleEvent: null));
    await _eventsRepository.saveScheduleEvent(event, token);
  }
}
