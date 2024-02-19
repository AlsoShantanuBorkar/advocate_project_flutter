import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:equatable/equatable.dart';

abstract class TeamMemberListEvent extends Equatable {}

class TeamMembersListSubscriptionRequstedEvent extends TeamMemberListEvent {
  TeamMembersListSubscriptionRequstedEvent();

  @override
  List<Object> get props => [];
}

class TeamMembersListDeleteTeamMemberEvent extends TeamMemberListEvent {
  TeamMembersListDeleteTeamMemberEvent({required this.teamMemberModel});

  final TeamMember teamMemberModel;

  @override
  List<Object> get props => [teamMemberModel];
}

class TeamMembersListUndoDeleteTeamMemberEvent extends TeamMemberListEvent {
  TeamMembersListUndoDeleteTeamMemberEvent();

  @override
  List<Object> get props => [];
}
