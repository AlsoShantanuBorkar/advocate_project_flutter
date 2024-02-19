import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:equatable/equatable.dart';

class TeamMemberListState extends Equatable {
  const TeamMemberListState({
    this.teamMemberListStatus = TeamMemberListStatus.init,
    this.teamMemberList = const [],
    this.lastDeletedTeamMember,
  });

  final TeamMemberListStatus teamMemberListStatus;
  final List<TeamMember> teamMemberList;
  final TeamMember? lastDeletedTeamMember;

  TeamMemberListState copyWith({
    TeamMemberListStatus? teamMemberListStatus,
    List<TeamMember>? teamMemberList,
    TeamMember? lastDeletedTeamMember,
  }) {
    return TeamMemberListState(
      teamMemberListStatus: teamMemberListStatus ?? this.teamMemberListStatus,
      teamMemberList: teamMemberList ?? this.teamMemberList,
      lastDeletedTeamMember:
          lastDeletedTeamMember ?? this.lastDeletedTeamMember,
    );
  }

  @override
  List<Object?> get props =>
      [teamMemberListStatus, teamMemberList, lastDeletedTeamMember];
}
