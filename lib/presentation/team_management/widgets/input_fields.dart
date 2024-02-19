import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_events.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_events.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class TeamMemberFirstNameField extends StatelessWidget {
  const TeamMemberFirstNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.firstName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.firstName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "First Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberFirstNameChanged(value));
      },
    );
  }
}

class TeamMemberLastNameField extends StatelessWidget {
  const TeamMemberLastNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.lastName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.lastName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Last Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberLastNameChanged(value));
      },
    );
  }
}

class TeamMemberPhoneNumberField extends StatelessWidget {
  const TeamMemberPhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.phoneNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().phone().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.phoneNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Phone Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberPhoneNumberChanged(value));
      },
    );
  }
}

class TeamMemberEmailField extends StatelessWidget {
  const TeamMemberEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.email ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.email,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Email",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberEmailChanged(value));
      },
    );
  }
}

class TeamMemberPasswordField extends StatelessWidget {
  const TeamMemberPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.password ?? '';

    return TextFormField(
      validator: ValidationBuilder().minLength(8).required().build(),
      obscureText: true,
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.password,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Password",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberPasswordChanged(value));
      },
    );
  }
}

class TeamMemberAddressField extends StatelessWidget {
  const TeamMemberAddressField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.address ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.address,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Address",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberAddressChanged(value));
      },
    );
  }
}

class TeamMemberRoleField extends StatelessWidget {
  const TeamMemberRoleField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTeamMemberBloc>().state;
    final hintText = state.initialTeamMember?.role ?? '';

    return TextFormField(
      validator: ValidationBuilder().email().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.role,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Role",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 30,
      onChanged: (value) {
        context
            .read<EditTeamMemberBloc>()
            .add(EditTeamMemberRoleChanged(value));
      },
    );
  }
}
