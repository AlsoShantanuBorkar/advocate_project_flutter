import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_state.dart';
import 'package:advocate_project_flutter/blocs/edit_task_bloc/edit_task_events.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_events.dart';
import 'package:advocate_project_flutter/blocs/edit_team_bloc/edit_team_member_state.dart';
import 'package:advocate_project_flutter/constants/enums/task_enums.dart';
import 'package:advocate_project_flutter/constants/enums/team_enums.dart';
import 'package:advocate_project_flutter/models/task_model.dart';
import 'package:advocate_project_flutter/models/team_member_model.dart';
import 'package:advocate_project_flutter/presentation/task_management/widgets/input_fields.dart';
import 'package:advocate_project_flutter/presentation/team_management/widgets/input_fields.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:advocate_project_flutter/repositories/team_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTeamPage extends StatelessWidget {
  const EditTeamPage({super.key});

  static Route<void> route({TeamMember? initialTeamMember}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTeamMemberBloc(
          teamMembersRepository: context.read<TeamMembersRepository>(),
          initialTeamMember: initialTeamMember,
        ),
        child: const EditTeamPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTeamMemberBloc, EditTeamMemberState>(
      listenWhen: (previous, current) =>
          previous.stateStatus != current.stateStatus &&
          current.stateStatus == EditTeamMemberStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTeamMember(),
    );
  }
}

class EditTeamMember extends StatefulWidget {
  const EditTeamMember({super.key});

  @override
  State<EditTeamMember> createState() => _EditTeamMemberState();
}

class _EditTeamMemberState extends State<EditTeamMember> {
  final PageController controller = PageController();
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNewTeamMember = context.select(
      (EditTeamMemberBloc bloc) => bloc.state.isNewTeamMember,
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          isNewTeamMember ? "Add New Member" : "Edit Member",
          style: const TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberFirstNameField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberLastNameField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberPhoneNumberField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberPasswordField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberAddressField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamMemberEmailField(),
                  const SizedBox(
                    height: 30,
                  ),
                  const TeamMemberRoleField(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            context
                                .read<EditTeamMemberBloc>()
                                .add(const EditTeamMemberSubmitted());
                            if (!isNewTeamMember) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
