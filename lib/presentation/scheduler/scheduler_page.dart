import 'dart:developer';
import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_events.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/scheduler/edit_schedule_event_page.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulerListPage extends StatelessWidget {
  const SchedulerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleEventListBloc(
        token: context.read<AuthCubit>().state.isLoggedIn
            ? context.read<AuthCubit>().state.user!.token!
            : "",
        eventsRepository: context.read<ScheduleEventRepository>(),
      )..add(
          SchedulesListSubscriptionRequstedEvent(),
        ),
      child: const ScheduleList(),
    );
  }
}

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  DateTime _selectedDate = DateTime(2024);
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      fab: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            EditScheduleEventPage.route(date: _selectedDate),
          );
        },
      ),
      pageTitle: "Scheduler",
      body: MultiBlocListener(
        listeners: [
          BlocListener<ScheduleEventListBloc, ScheduleListEventState>(
            listenWhen: (previous, current) =>
                previous.eventListStatus != current.eventListStatus,
            listener: (context, ScheduleListEventState state) {
              if (state.eventListStatus ==
                  ScheduleEventListStateStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Operation Failed"),
                    ),
                  );
              }
            },
          ),
          BlocListener<ScheduleEventListBloc, ScheduleListEventState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedScheduleEvent !=
                    current.lastDeletedScheduleEvent &&
                current.lastDeletedScheduleEvent != null,
            listener: (context, state) {
              final ScheduleEvent deletedScheduleEvent =
                  state.lastDeletedScheduleEvent!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Text(
                      "Deleted Event : ${deletedScheduleEvent.eventCaseNumber}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context.read<ScheduleEventListBloc>().add(
                              SchedulesListUndoDeleteScheduleEvent(),
                            );
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<ScheduleEventListBloc, ScheduleListEventState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TableCalendar(
                          eventLoader: (DateTime dateTime) {
                            return state.eventList
                                .where(
                                  (element) =>
                                      element.eventDate
                                          .toIso8601String()
                                          .substring(0, 10) ==
                                      dateTime
                                          .toIso8601String()
                                          .substring(0, 10),
                                )
                                .toList();
                          },
                          availableCalendarFormats: const {
                            CalendarFormat.month: 'Month'
                          },
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDate, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(
                              () {
                                _selectedDate = selectedDay;
                              },
                            );
                          },
                          calendarFormat: CalendarFormat.month,
                          headerStyle: const HeaderStyle(titleCentered: true),
                          calendarStyle: CalendarStyle(
                            holidayTextStyle:
                                const TextStyle(color: Colors.green),
                            weekendTextStyle:
                                const TextStyle(color: Colors.redAccent),
                            selectedTextStyle:
                                const TextStyle(color: Colors.black),
                            todayDecoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            selectedDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1),
                            ),
                            markerDecoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.purple),
                          ),
                          focusedDay: DateTime.now(),
                          firstDay: DateTime(2024),
                          lastDay: DateTime(2025),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state.eventListStatus ==
                            ScheduleEventListStateStatus.loading
                        ? const CircularProgressIndicator()
                        : state.eventList
                                .where(
                                  (element) =>
                                      element.eventDate
                                          .toIso8601String()
                                          .substring(0, 10) ==
                                      _selectedDate
                                          .toIso8601String()
                                          .substring(0, 10),
                                )
                                .toList()
                                .isNotEmpty
                            ? EventsList(
                                eventsList: state.eventList
                                    .where(
                                      (element) =>
                                          element.eventDate
                                              .toIso8601String()
                                              .substring(0, 10) ==
                                          _selectedDate
                                              .toIso8601String()
                                              .substring(0, 10),
                                    )
                                    .toList(),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  "No Events Scheduled",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScheduleListWidget extends StatefulWidget {
  const ScheduleListWidget({super.key});

  @override
  State<ScheduleListWidget> createState() => _ScheduleListWidgetState();
}

class _ScheduleListWidgetState extends State<ScheduleListWidget> {
  DateTime _selectedDate = DateTime(2024);
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScheduleEventListBloc, ScheduleListEventState>(
          listenWhen: (previous, current) =>
              previous.eventListStatus != current.eventListStatus,
          listener: (context, ScheduleListEventState state) {
            if (state.eventListStatus == ScheduleEventListStateStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text("Operation Failed"),
                  ),
                );
            }
          },
        ),
        BlocListener<ScheduleEventListBloc, ScheduleListEventState>(
          listenWhen: (previous, current) =>
              previous.lastDeletedScheduleEvent !=
                  current.lastDeletedScheduleEvent &&
              current.lastDeletedScheduleEvent != null,
          listener: (context, state) {
            final ScheduleEvent deletedScheduleEvent =
                state.lastDeletedScheduleEvent!;
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Text(
                    "Deleted Event : ${deletedScheduleEvent.eventCaseNumber}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      context.read<ScheduleEventListBloc>().add(
                            SchedulesListUndoDeleteScheduleEvent(),
                          );
                    },
                  ),
                ),
              );
          },
        ),
      ],
      child: BlocBuilder<ScheduleEventListBloc, ScheduleListEventState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: TableCalendar(
                        eventLoader: (DateTime dateTime) {
                          return state.eventList
                              .where(
                                (element) =>
                                    element.eventDate
                                        .toIso8601String()
                                        .substring(0, 10) ==
                                    dateTime.toIso8601String().substring(0, 10),
                              )
                              .toList();
                        },
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month'
                        },
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(
                            () {
                              _selectedDate = selectedDay;
                            },
                          );
                        },
                        calendarFormat: CalendarFormat.month,
                        headerStyle: const HeaderStyle(titleCentered: true),
                        calendarStyle: CalendarStyle(
                          holidayTextStyle:
                              const TextStyle(color: Colors.green),
                          weekendTextStyle:
                              const TextStyle(color: Colors.redAccent),
                          selectedTextStyle:
                              const TextStyle(color: Colors.black),
                          todayDecoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1),
                          ),
                          markerDecoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.purple),
                        ),
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(2024),
                        lastDay: DateTime(2025),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.eventListStatus == ScheduleEventListStateStatus.loading
                      ? const CircularProgressIndicator()
                      : state.eventList
                              .where(
                                (element) =>
                                    element.eventDate
                                        .toIso8601String()
                                        .substring(0, 10) ==
                                    _selectedDate
                                        .toIso8601String()
                                        .substring(0, 10),
                              )
                              .toList()
                              .isNotEmpty
                          ? EventsList(
                              eventsList: state.eventList
                                  .where(
                                    (element) =>
                                        element.eventDate
                                            .toIso8601String()
                                            .substring(0, 10) ==
                                        _selectedDate
                                            .toIso8601String()
                                            .substring(0, 10),
                                  )
                                  .toList(),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                "No Events Scheduled",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  const EventsList({super.key, required this.eventsList});
  final List<ScheduleEvent> eventsList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: eventsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: Colors.black,
            elevation: 1,
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                EditScheduleEventPage.route(
                                    initialScheduleEvent: eventsList[index],
                                    date: eventsList[index].eventDate),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: const Text(
                              "Edit Event",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ScheduleEventListBloc>().add(
                                    SchedulesListDeleteScheduleEvent(
                                      scheduleEvent: eventsList[index],
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: const Text(
                              "Delete Event",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(eventsList[index].eventCaseNumber),
              subtitle: Text(eventsList[index].eventCaseNote),
              trailing: Text(
                eventsList[index].eventTime.format(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
