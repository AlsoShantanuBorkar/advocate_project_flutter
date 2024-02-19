import 'package:equatable/equatable.dart';

sealed class EditTeamMemberEvent extends Equatable {
  const EditTeamMemberEvent();

  @override
  List<Object?> get props => [];
}

final class EditTeamMemberFirstNameChanged extends EditTeamMemberEvent {
  const EditTeamMemberFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class EditTeamMemberLastNameChanged extends EditTeamMemberEvent {
  const EditTeamMemberLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class EditTeamMemberPasswordChanged extends EditTeamMemberEvent {
  const EditTeamMemberPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class EditTeamMemberAddressChanged extends EditTeamMemberEvent {
  const EditTeamMemberAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class EditTeamMemberEmailChanged extends EditTeamMemberEvent {
  const EditTeamMemberEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class EditTeamMemberRoleChanged extends EditTeamMemberEvent {
  const EditTeamMemberRoleChanged(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class EditTeamMemberPhoneNumberChanged extends EditTeamMemberEvent {
  const EditTeamMemberPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class EditTeamMemberSubmitted extends EditTeamMemberEvent {
  const EditTeamMemberSubmitted();

  @override
  List<Object> get props => [];
}
