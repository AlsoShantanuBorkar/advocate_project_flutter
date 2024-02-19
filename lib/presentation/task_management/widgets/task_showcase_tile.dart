import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskShowcaseTile extends StatelessWidget {
  const TaskShowcaseTile({
    super.key,
    required this.taskModel,
  });
  final Task taskModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.black,
        elevation: 1,
        child: ListTile(
          onTap: () {
            // Navigator.of(context).push(
            //   TaskDetailsPage.route(
            //       taskModel: taskModel,
            //       onDelete: () {
            //         context.read<TaskListBloc>().add(
            //               TasksListDeleteTaskEvent(
            //                 taskModel: taskModel,
            //               ),
            //             );
            //       }),
            // );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          tileColor: Colors.white,
          leading: Text(
            "#${taskModel.taskId}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Chip(
            label: Text(
              taskModel.status.name,
              style: TextStyle(
                fontSize: 12,
                color: taskModel.status == TaskStatus.OPEN
                    ? Colors.indigo
                    : taskModel.status == TaskStatus.INACTIVE
                        ? Colors.red
                        : Colors.green,
              ),
            ),
            backgroundColor: taskModel.status == TaskStatus.OPEN
                ? Colors.indigo.shade50
                : taskModel.status == TaskStatus.INACTIVE
                    ? Colors.red.shade50
                    : Colors.green.shade50,
            side: BorderSide.none,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          horizontalTitleGap: 10,
          title: Text(
            taskModel.subject,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            DateTime.now().toIso8601String().substring(0, 10),
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
