import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_schedule_bloc/edit_schedule_events.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class EventCaseNumberField extends StatelessWidget {
  const EventCaseNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditScheduleEventBloc>().state;
    final hintText = state.initialScheduleEvent?.eventCaseNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.eventCaseNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      maxLines: 1,
      onChanged: (value) {
        context
            .read<EditScheduleEventBloc>()
            .add(EditScheduleCaseNumberChanged(value));
      },
    );
  }
}

class EventNotesField extends StatelessWidget {
  const EventNotesField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditScheduleEventBloc>().state;
    final hintText = state.initialScheduleEvent?.eventCaseNote ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.eventCaseNote,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Add Notes",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context
            .read<EditScheduleEventBloc>()
            .add(EditScheduleNoteChanged(value));
      },
    );
  }
}

class EventDateField extends StatelessWidget {
  const EventDateField({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    context
        .read<EditScheduleEventBloc>()
        .add(EditScheduleEventDateChanged(date));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Text(
            "Date :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(date.toIso8601String().substring(0, 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventTimeField extends StatelessWidget {
  const EventTimeField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditScheduleEventBloc>().state;
    return GestureDetector(
      onTap: () async {
        await showTimePicker(
          context: context,
          initialTime: state.eventTime,
        ).then(
          (value) {
            if (value != null) {
              context
                  .read<EditScheduleEventBloc>()
                  .add(EditScheduleEventTimeChanged(value));
            }
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const Text(
              "Select Time :",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    Icons.punch_clock_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(state.eventTime.format(context))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
