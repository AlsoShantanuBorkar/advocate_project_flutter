import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_events.dart';
import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_state.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/presentation/scheduler/widgets/input_fields.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScheduleEventPage extends StatelessWidget {
  const EditScheduleEventPage({super.key, required this.date});
  final DateTime date;
  static Route<void> route(
      {ScheduleEvent? initialScheduleEvent, required DateTime date}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditScheduleEventBloc(
          eventsRepository: context.read<ScheduleEventRepository>(),
          initialScheduleEvent: initialScheduleEvent,
        ),
        child: EditScheduleEventPage(
          date: date,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditScheduleEventBloc, EditScheduleEventState>(
      listenWhen: (previous, current) =>
          previous.stateStatus != current.stateStatus &&
          current.stateStatus == EditScheduleEventStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: EditScheduleEvent(
        date: date,
      ),
    );
  }
}

class EditScheduleEvent extends StatefulWidget {
  const EditScheduleEvent({super.key, required this.date});
  final DateTime date;
  @override
  State<EditScheduleEvent> createState() => _EditScheduleEventState();
}

class _EditScheduleEventState extends State<EditScheduleEvent> {
  final PageController controller = PageController();
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNewScheduleEvent = context.select(
      (EditScheduleEventBloc bloc) => bloc.state.isNewScheduleEvent,
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          isNewScheduleEvent ? "Add New Event" : "Edit Event",
          style: const TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const EventCaseNumberField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const EventNotesField(),
                  const SizedBox(
                    height: 10,
                  ),
                  EventDateField(date: widget.date),
                  const SizedBox(
                    height: 10,
                  ),
                  const EventTimeField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            context
                                .read<EditScheduleEventBloc>()
                                .add(const EditScheduleSubmitted());
                            if (!isNewScheduleEvent) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
