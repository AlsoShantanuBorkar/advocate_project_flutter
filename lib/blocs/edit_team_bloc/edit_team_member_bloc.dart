import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_events.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_state.dart';
import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:advocate_project_flutter/repositories/team_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTeamMemberBloc
    extends Bloc<EditTeamMemberEvent, EditTeamMemberState> {
  EditTeamMemberBloc({
    required TeamMembersRepository teamMembersRepository,
    required TeamMember? initialTeamMember,
  })  : _teamMembersRepository = teamMembersRepository,
        super(EditTeamMemberState(
          initialTeamMember: initialTeamMember,
          phoneNumber: initialTeamMember?.phoneNumber ?? "",
          address: initialTeamMember?.address ?? "",
          email: initialTeamMember?.email ?? "",
          role: initialTeamMember?.role ?? "",
          password: initialTeamMember?.password ?? "",
          lastName: initialTeamMember?.lastName ?? "",
          firstName: initialTeamMember?.firstName ?? "",
        )) {
    on<EditTeamMemberFirstNameChanged>(_onTeamMemberFirstNameChanged);

    on<EditTeamMemberLastNameChanged>(_onTeamMemberLastNameChanged);

    on<EditTeamMemberAddressChanged>(_onTeamMemberAddressChanged);

    on<EditTeamMemberPhoneNumberChanged>(_onTeamMemberPhoneNumberChanged);

    on<EditTeamMemberPasswordChanged>(_onTeamMemberPasswordChanged);

    on<EditTeamMemberRoleChanged>(_onTeamMemberRoleChanged);

    on<EditTeamMemberEmailChanged>(_onTeamMemberEmailChanged);

    on<EditTeamMemberSubmitted>(_onSubmitted);
  }

  final TeamMembersRepository _teamMembersRepository;

  void _onTeamMemberFirstNameChanged(
    EditTeamMemberFirstNameChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onTeamMemberLastNameChanged(
    EditTeamMemberLastNameChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onTeamMemberAddressChanged(
    EditTeamMemberAddressChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(address: event.address));
  }

  void _onTeamMemberEmailChanged(
    EditTeamMemberEmailChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onTeamMemberRoleChanged(
    EditTeamMemberRoleChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  void _onTeamMemberPasswordChanged(
    EditTeamMemberPasswordChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(address: event.password));
  }

  void _onTeamMemberPhoneNumberChanged(
    EditTeamMemberPhoneNumberChanged event,
    Emitter<EditTeamMemberState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onSubmitted(
    EditTeamMemberSubmitted event,
    Emitter<EditTeamMemberState> emit,
  ) async {
    emit(state.copyWith(stateStatus: EditTeamMemberStatus.loading));
    final TeamMember newTeamMember = (state.initialTeamMember ??
            const TeamMember(
              phoneNumber: "",
              address: "",
              email: "",
              role: "",
              password: "",
              lastName: "",
              firstName: "",
            ))
        .copyWith(
      phoneNumber: state.phoneNumber,
      address: state.address,
      email: state.email,
      role: state.role,
      password: state.password,
      lastName: state.lastName,
      firstName: state.firstName,
    );

    try {
      if (state.initialTeamMember != null) {
        await _teamMembersRepository
            .deleteTeamMember(state.initialTeamMember!.email);
      }
      await _teamMembersRepository.saveTeamMember(newTeamMember);
      emit(state.copyWith(stateStatus: EditTeamMemberStatus.success));
    } catch (e) {
      emit(state.copyWith(stateStatus: EditTeamMemberStatus.failure));
    }
  }
}
