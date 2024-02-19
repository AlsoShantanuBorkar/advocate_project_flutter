import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_events.dart';
import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_state.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScheduleEventBloc
    extends Bloc<EditScheduleEvent, EditScheduleEventState> {
  final String token;
  EditScheduleEventBloc({
    this.token = "",
    required ScheduleEventRepository eventsRepository,
    required ScheduleEvent? initialScheduleEvent,
  })  : _eventsRepository = eventsRepository,
        super(EditScheduleEventState(
            initialScheduleEvent: initialScheduleEvent,
            eventCaseNumber: initialScheduleEvent?.eventCaseNumber ?? "",
            eventCaseNote: initialScheduleEvent?.eventCaseNote ?? "",
            eventDate: initialScheduleEvent?.eventDate ?? DateTime(2024),
            eventTime: initialScheduleEvent?.eventTime ??
                const TimeOfDay(hour: 0, minute: 0))) {
    on<EditScheduleCaseNumberChanged>(_onScheduleEventCaseNumberChanged);
    on<EditScheduleNoteChanged>(_onScheduleEventNoteChanged);
    on<EditScheduleEventDateChanged>(_onScheduleEventDateChanged);
    on<EditScheduleEventTimeChanged>(_onScheduleEventTimeChanged);
    on<EditScheduleSubmitted>(_onSubmitted);
  }

  final ScheduleEventRepository _eventsRepository;

  void _onScheduleEventCaseNumberChanged(
    EditScheduleCaseNumberChanged event,
    Emitter<EditScheduleEventState> emit,
  ) {
    emit(state.copyWith(eventCaseNumber: event.eventCaseNumber));
  }

  void _onScheduleEventNoteChanged(
    EditScheduleNoteChanged event,
    Emitter<EditScheduleEventState> emit,
  ) {
    emit(state.copyWith(eventCaseNote: event.eventCaseNote));
  }

  void _onScheduleEventDateChanged(
    EditScheduleEventDateChanged event,
    Emitter<EditScheduleEventState> emit,
  ) {
    emit(state.copyWith(eventDate: event.eventDate));
  }

  void _onScheduleEventTimeChanged(
    EditScheduleEventTimeChanged event,
    Emitter<EditScheduleEventState> emit,
  ) {
    emit(state.copyWith(eventTime: event.eventTime));
  }

  void _onSubmitted(
    EditScheduleSubmitted event,
    Emitter<EditScheduleEventState> emit,
  ) async {
    emit(state.copyWith(stateStatus: EditScheduleEventStatus.loading));
    final ScheduleEvent newScheduleEvent = (state.initialScheduleEvent ??
            ScheduleEvent(
              eventCaseNumber: '',
              eventDate: DateTime(2024),
              eventTime: TimeOfDay(hour: 0, minute: 0),
              eventCaseNote: "",
            ))
        .copyWith(
      eventCaseNumber: state.eventCaseNumber,
      eventDate: state.eventDate,
      eventTime: state.eventTime,
      eventCaseNote: state.eventCaseNote,
    );
    ;

    try {
      if (state.initialScheduleEvent != null) {
        await _eventsRepository.deleteScheduleEvent(
          state.initialScheduleEvent!.eventCaseNumber,
          token,
        );
      }
      await _eventsRepository.saveScheduleEvent(newScheduleEvent, token);
      emit(state.copyWith(stateStatus: EditScheduleEventStatus.success));
    } catch (e) {
      emit(state.copyWith(stateStatus: EditScheduleEventStatus.failure));
    }
  }
}
