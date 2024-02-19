import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_events.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:advocate_project_flutter/presentation/task_management/edit_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMemberShowcaseTile extends StatelessWidget {
  const TeamMemberShowcaseTile(
      {super.key, required this.teamMember, required this.onDelete});
  final TeamMember teamMember;
  final Function onDelete;
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
                            const Icon(
                              Icons.person,
                              size: 40,
                            ),
                            Text(
                                "${teamMember.firstName} ${teamMember.lastName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(teamMember.role),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(teamMember.email),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  EditTasksPage.route(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                "Edit Member",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<TeamMemberListBloc>().add(
                                    TeamMembersListDeleteTeamMemberEvent(
                                        teamMemberModel: teamMember));
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                "Delete Member",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          title: Text(
            "${teamMember.firstName} ${teamMember.lastName}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          tileColor: Colors.white,
          leading: const Icon(Icons.person),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Text(teamMember.email), Text(teamMember.phoneNumber)],
          ),
          trailing: Chip(label: Text(teamMember.role)),
        ),
      ),
    );
  }
}
