import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_events.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:advocate_project_flutter/repositories/team_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMemberListBloc
    extends Bloc<TeamMemberListEvent, TeamMemberListState> {
  final TeamMembersRepository _teamMembersRepository;

  TeamMemberListBloc({required TeamMembersRepository teamMembersRepository})
      : _teamMembersRepository = teamMembersRepository,
        super(const TeamMemberListState()) {
    on<TeamMembersListSubscriptionRequstedEvent>(
        _onTeamMembersListSubscriptionRequstedEvent);
    on<TeamMembersListDeleteTeamMemberEvent>(
        _onTeamMembersListDeleteTeamMemberEvent);
    on<TeamMembersListUndoDeleteTeamMemberEvent>(
        _onTeamMembersListUndoDeleteTeamMember);
  }

  Future<void> _onTeamMembersListSubscriptionRequstedEvent(
    TeamMembersListSubscriptionRequstedEvent event,
    Emitter<TeamMemberListState> emit,
  ) async {
    emit(state.copyWith(teamMemberListStatus: TeamMemberListStatus.init));

    await emit.forEach<List<TeamMember>>(
      _teamMembersRepository.getTeamMembers(),
      onData: (teamMemberModelList) => state.copyWith(
        teamMemberListStatus: TeamMemberListStatus.success,
        teamMemberList: teamMemberModelList,
      ),
      onError: (_, __) => state.copyWith(
        teamMemberListStatus: TeamMemberListStatus.failure,
      ),
    );
  }

  Future<void> _onTeamMembersListDeleteTeamMemberEvent(
    TeamMembersListDeleteTeamMemberEvent event,
    Emitter<TeamMemberListState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTeamMember: event.teamMemberModel));
    await _teamMembersRepository.deleteTeamMember(event.teamMemberModel.email);
  }

  Future<void> _onTeamMembersListUndoDeleteTeamMember(
    TeamMembersListUndoDeleteTeamMemberEvent event,
    Emitter<TeamMemberListState> emit,
  ) async {
    assert(
      state.lastDeletedTeamMember != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedTeamMember!;
    emit(state.copyWith(lastDeletedTeamMember: null));
    await _teamMembersRepository.saveTeamMember(todo);
  }
}
