import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_events.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class TaskCaseNumberField extends StatelessWidget {
  const TaskCaseNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.caseNumber ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.caseNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      validator: ValidationBuilder().required().build(),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskCaseNumberChanged(value));
      },
    );
  }
}

class TaskIDField extends StatelessWidget {
  const TaskIDField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.taskId ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.taskId,
      validator: ValidationBuilder().required().build(),
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Task ID",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskIdChanged(value));
      },
    );
  }
}

class TaskSubjectField extends StatelessWidget {
  const TaskSubjectField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.subject ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.taskSubject,
      validator: ValidationBuilder().required().build(),
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Task Subject",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskSubjectChanged(value));
      },
    );
  }
}

class TaskDescriptionField extends StatelessWidget {
  const TaskDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.taskDescription ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.taskDescription,
      maxLines: 5,
      validator: ValidationBuilder().required().build(),
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Task Description",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 300,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskDescriptionChanged(value));
      },
    );
  }
}

class TaskCasePersonNameField extends StatelessWidget {
  const TaskCasePersonNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.casePersonName ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      validator: ValidationBuilder().required().build(),
      initialValue: state.casePersonName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case Person Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskCasePersonNameChanged(value));
      },
    );
  }
}

class TaskStatusDropdown extends StatelessWidget {
  const TaskStatusDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Row(
      children: [
        const Text(
          "Task Status : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<TaskStatus>(
            onSelected: (value) {
              context.read<EditTaskBloc>().add(EditTaskStatusChanged(value!));
            },
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: const BoxConstraints(maxWidth: 150),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            initialSelection: state.taskStatus,
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: TaskStatus.OPEN,
                label: "OPEN",
              ),
              DropdownMenuEntry(
                value: TaskStatus.PENDING,
                label: "PENDING",
              ),
              DropdownMenuEntry(
                value: TaskStatus.INACTIVE,
                label: "INACTIVE",
              )
            ]),
      ],
    );
  }
}

class TaskPriorityDropdown extends StatelessWidget {
  const TaskPriorityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Row(
      children: [
        const Text(
          "Task Priority : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<TaskPriority>(
            onSelected: (value) {
              context.read<EditTaskBloc>().add(EditTaskPriorityChanged(value!));
            },
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: const BoxConstraints(maxWidth: 150),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            initialSelection: state.taskPriority,
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: TaskPriority.HIGH,
                label: "HIGH",
              ),
              DropdownMenuEntry(
                value: TaskPriority.LOW,
                label: "LOW",
              ),
              DropdownMenuEntry(
                value: TaskPriority.MEDIUM,
                label: "MEDIUM",
              )
            ]),
      ],
    );
  }
}

class DeadlinePicker extends StatelessWidget {
  const DeadlinePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Row(
      children: [
        const Text(
          "Deadline :",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  ).then((value) {
                    if (value != null) {
                      context
                          .read<EditTaskBloc>()
                          .add(EditTaskDeadlineChanged(value));
                    }
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              Text(state.deadline.toIso8601String().substring(0, 10))
            ],
          ),
        ),
      ],
    );
  }
}

class StartDatePicker extends StatelessWidget {
  const StartDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Row(
      children: [
        const Text(
          "Start Date :",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  ).then((value) {
                    if (value != null) {
                      context
                          .read<EditTaskBloc>()
                          .add(EditTaskStartDateChanged(value));
                    }
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              Text(state.startDate.toIso8601String().substring(0, 10))
            ],
          ),
        ),
      ],
    );
  }
}

class TaskAssignedToField extends StatelessWidget {
  const TaskAssignedToField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.casePersonName ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.assignedTo,
      validator: ValidationBuilder().required().build(),
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Assigned To",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 300,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskAssignedToChanged(value));
      },
    );
  }
}

class TaskRelatedToField extends StatelessWidget {
  const TaskRelatedToField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;
    final hintText = state.initialTask?.casePersonName ?? '';

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.relatedTo,
      validator: ValidationBuilder().required().build(),
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Related To",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 300,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditTaskBloc>().add(EditTaskRelatedToChanged(value));
      },
    );
  }
}
