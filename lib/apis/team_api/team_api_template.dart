import 'package:advocate_project_flutter/models/team_member_model.dart';

abstract class AbstractTeamMemberAPI {
  const AbstractTeamMemberAPI();

  Stream<List<TeamMember>> getTeamMembers();

  Future<void> saveTeamMember(TeamMember teamMemberModel);

  Future<void> deleteTeamMember(String memberEmail);
}

class TeamMemberNotFoundException implements Exception {}
