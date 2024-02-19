import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_state.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_events.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:advocate_project_flutter/presentation/task_management/widgets/input_fields.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTasksPage extends StatelessWidget {
  const EditTasksPage({super.key});

  static Route<void> route({Task? initialTask}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTaskBloc(
          token: context.read<AuthCubit>().state.isLoggedIn
              ? context.read<AuthCubit>().state.user!.token!
              : "",
          tasksRepository: context.read<TasksRepository>(),
          initialTask: initialTask,
        ),
        child: const EditTasksPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskBloc, EditTaskState>(
      listenWhen: (previous, current) =>
          previous.stateStatus != current.stateStatus &&
          current.stateStatus == EditTaskStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTask(),
    );
  }
}

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final PageController controller = PageController();
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNewTask = context.select(
      (EditTaskBloc bloc) => bloc.state.isNewTask,
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          isNewTask ? "Add New Task" : "Edit Task",
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
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskIDField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskSubjectField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskCasePersonNameField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskCaseNumberField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskPriorityDropdown(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskStatusDropdown(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskAssignedToField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskRelatedToField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const StartDatePicker(),
                  const SizedBox(
                    height: 10,
                  ),
                  const DeadlinePicker(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TaskDescriptionField(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context
                              .read<EditTaskBloc>()
                              .add(const EditTaskSubmitted());
                          if (!isNewTask) {
                            Navigator.pop(context);
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
