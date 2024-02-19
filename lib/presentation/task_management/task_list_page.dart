import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/task_list_bloc/task_list_events.dart';
import 'package:advocate_project_flutter/blocs/task_list_bloc/task_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:advocate_project_flutter/presentation/task_management/edit_task_page.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/task_management/widgets/task_showcase_tile.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskListBloc(
        token: context.read<AuthCubit>().state.isLoggedIn
            ? context.read<AuthCubit>().state.user!.token!
            : "",
        tasksRepository: context.read<TasksRepository>(),
      )..add(TasksListSubscriptionRequstedEvent()),
      child: const TaskList(),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

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
            EditTasksPage.route(),
          );
        },
      ),
      pageTitle: "Tasks",
      body: MultiBlocListener(
        listeners: [
          BlocListener<TaskListBloc, TaskListState>(
            listenWhen: (previous, current) =>
                previous.taskListStatus != current.taskListStatus,
            listener: (context, TaskListState state) {
              if (state.taskListStatus == TaskListStatus.failure) {
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
          BlocListener<TaskListBloc, TaskListState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTask != current.lastDeletedTask &&
                current.lastDeletedTask != null,
            listener: (context, state) {
              final Task deletedTask = state.lastDeletedTask!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Text(
                      "Deleted Task : ${deletedTask.taskId}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TaskListBloc>()
                            .add(TasksListUndoDeleteTaskEvent());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            if (state.taskList.isEmpty) {
              if (state.taskListStatus == TaskListStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.taskListStatus != TaskListStatus.success) {
                return const Center(child: Text("Error Occured"));
              } else {
                return const Center(
                  child: Text(
                    "No Tasks Found",
                  ),
                );
              }
            }
            List<Widget> tasks = (List.from(state.filteredTasks.toList()))
                .map(
                  (e) => TaskShowcaseTile(
                    taskModel: e,
                  ),
                )
                .toList()
                .reversed
                .toList();

            return ListView(
              children: tasks,
            );
          },
        ),
      ),
    );
  }
}
