import 'dart:async';
import 'dart:convert';
import 'package:advocate_project_flutter/apis/team_api/team_api_template.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TeamMemberAPI extends AbstractTeamMemberAPI {
  TeamMemberAPI({
    required SharedPreferences sharedPreferencesIntsance,
  }) : _sharedPreferencesIntsance = sharedPreferencesIntsance {
    _init();
  }

  final SharedPreferences _sharedPreferencesIntsance;

  final BehaviorSubject<List<TeamMember>> _teamMemberStreamController =
      BehaviorSubject<List<TeamMember>>.seeded(const []);

  static const _kTeamMembersCollectionKey = '__members_collection_key__';

  String? _getValue(String key) => _sharedPreferencesIntsance.getString(key);
  Future<void> _setValue(String key, String value) =>
      _sharedPreferencesIntsance.setString(key, value);

  void _init() {
    final String? teamMembersJson = _getValue(_kTeamMembersCollectionKey);
    if (teamMembersJson != null) {
      List x = jsonDecode(teamMembersJson);
      List<TeamMember> teamMembers =
          x.map((e) => TeamMember.fromJson(e)).toList();
      _teamMemberStreamController.add(teamMembers);
    } else {
      _teamMemberStreamController.add(const []);
    }
  }

  Future<void> fetchTeamMembers() async {
    try {
      Uri uri = Uri.parse("http://localhost:3000/api/v1/teamMember");
      http.Response response = await http.get(uri, headers: {"token": ""});
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedResponse =
            (jsonDecode(response.body) as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
        final List<TeamMember> teamMembers = [
          ..._teamMemberStreamController.value
        ];
        decodedResponse.forEach((element) {
          TeamMember teamMemberModel = TeamMember.fromMap(element);
          teamMembers.add(teamMemberModel);
        });
        _teamMemberStreamController.add(teamMembers);
        return _setValue(_kTeamMembersCollectionKey, json.encode(teamMembers));
      } else {}
    } catch (e) {}
  }

  @override
  Stream<List<TeamMember>> getTeamMembers() {
    // fetchTeamMembers();
    return _teamMemberStreamController.asBroadcastStream();
  }

  @override
  Future<void> saveTeamMember(TeamMember teamMemberModel) async {
    // try {
    //   Uri uri = Uri.parse("");
    //   http.Response response = await http.post(uri, body: teamMemberModel.toJson());
    //   if (response.statusCode == 200) {
    //   } else {}
    // } catch (e) {}
    final teamMembers = [..._teamMemberStreamController.value];
    final teamMemberModelIndex =
        teamMembers.indexWhere((t) => t.email == teamMemberModel.email);
    if (teamMemberModelIndex >= 0) {
      teamMembers[teamMemberModelIndex] = teamMemberModel;
    } else {
      teamMembers.add(teamMemberModel);
    }

    _teamMemberStreamController.add(teamMembers);
    return _setValue(_kTeamMembersCollectionKey, json.encode(teamMembers));
  }

  @override
  Future<void> deleteTeamMember(String email) async {
    // try {
    //   Uri uri = Uri.parse("");
    //   http.Response response = await http.delete(uri);
    //   if (response.statusCode == 200) {
    //   } else {}
    // } catch (e) {}

    final teamMembers = [..._teamMemberStreamController.value];
    final recordIndex = teamMembers.indexWhere((t) => t.email == email);
    if (recordIndex == -1) {
      throw TeamMemberNotFoundException();
    } else {
      teamMembers.removeAt(recordIndex);
      _teamMemberStreamController.add(teamMembers);
      return _setValue(_kTeamMembersCollectionKey, json.encode(teamMembers));
    }
  }
}
