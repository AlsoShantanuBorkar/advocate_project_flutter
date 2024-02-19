// ignore_for_file: non_constant_identifier_names

import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:equatable/equatable.dart';

class EditTeamMemberState extends Equatable {
  final EditTeamMemberStatus stateStatus;
  final TeamMember? initialTeamMember;

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  final String address;

  const EditTeamMemberState({
    this.stateStatus = EditTeamMemberStatus.initial,
    required this.initialTeamMember,
    required this.address,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
    required this.role,
  });

  bool get isNewTeamMember => initialTeamMember == null;

  EditTeamMemberState copyWith({
    EditTeamMemberStatus? stateStatus,
    TeamMember? initialTeamMember,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
    String? role,
    String? address,
  }) {
    return EditTeamMemberState(
        stateStatus: stateStatus ?? this.stateStatus,
        initialTeamMember: initialTeamMember ?? this.initialTeamMember,
        firstName: firstName ?? this.firstName,
        email: email ?? this.email,
        address: address ?? this.address,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        role: role ?? this.role);
  }

  @override
  List<Object> get props {
    return [
      stateStatus,
      firstName,
      address,
      email,
      lastName,
      phoneNumber,
      password,
      role,
    ];
  }
}
