import 'package:advocate_project_flutter/apis/team_api/team_api.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';

class TeamMembersRepository {
  const TeamMembersRepository({
    required TeamMemberAPI teamMemberAPI,
  }) : _teamMemberAPI = teamMemberAPI;

  final TeamMemberAPI _teamMemberAPI;

  Stream<List<TeamMember>> getTeamMembers() => _teamMemberAPI.getTeamMembers();

  Future<void> saveTeamMember(TeamMember teamMember) =>
      _teamMemberAPI.saveTeamMember(teamMember);

  Future<void> deleteTeamMember(String id) =>
      _teamMemberAPI.deleteTeamMember(id);
}
