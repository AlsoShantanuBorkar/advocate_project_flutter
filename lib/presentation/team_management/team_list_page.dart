import 'package:advocate_project_flutter/presentation/team_management/widgets/team_member_showcase_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_events.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/team_management/edit_team_page.dart';

class TeamListPage extends StatelessWidget {
  const TeamListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeamList();
  }
}

class TeamList extends StatelessWidget {
  const TeamList({super.key});

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
            EditTeamPage.route(),
          );
        },
      ),
      pageTitle: "Team Members",
      body: MultiBlocListener(
        listeners: [
          BlocListener<TeamMemberListBloc, TeamMemberListState>(
            listenWhen: (previous, current) =>
                previous.teamMemberListStatus != current.teamMemberListStatus,
            listener: (context, TeamMemberListState state) {
              if (state.teamMemberListStatus == TeamMemberListStatus.failure) {
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
          BlocListener<TeamMemberListBloc, TeamMemberListState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTeamMember !=
                    current.lastDeletedTeamMember &&
                current.lastDeletedTeamMember != null,
            listener: (context, state) {
              final TeamMember deletedTeamMember = state.lastDeletedTeamMember!;
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
                      "Deleted TeamMember : ${deletedTeamMember.email}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TeamMemberListBloc>()
                            .add(TeamMembersListUndoDeleteTeamMemberEvent());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TeamMemberListBloc, TeamMemberListState>(
          builder: (context, state) {
            if (state.teamMemberList.isEmpty) {
              if (state.teamMemberListStatus == TeamMemberListStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.teamMemberListStatus !=
                  TeamMemberListStatus.success) {
                return const Center(child: Text("Error Occured"));
              } else {
                return const Center(
                  child: Text(
                    "No Team Members Found",
                  ),
                );
              }
            }
            List<Widget> teamMembers = state.teamMemberList
                .map(
                  (e) => TeamMemberShowcaseTile(
                    teamMember: e,
                    onDelete: () {
                      context.read<TeamMemberListBloc>().add(
                          TeamMembersListDeleteTeamMemberEvent(
                              teamMemberModel: e));
                    },
                  ),
                )
                .toList()
                .reversed
                .toList();

            return ListView(
              children: teamMembers,
            );
          },
        ),
      ),
    );
  }
}
