// ignore_for_file: unused_element

import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_state.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_events.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/presentation/case_management/widgets/input_fields.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCasesPage extends StatelessWidget {
  const EditCasesPage({super.key});

  static Route<void> route({Case? initialCase}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditCaseBloc(
          casesRepository: context.read<CasesRepository>(),
          token: context.read<AuthCubit>().state.isLoggedIn
              ? context.read<AuthCubit>().state.user!.token!
              : "",
          initialCase: initialCase,
        ),
        child: const EditCasesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCaseBloc, EditCaseState>(
      listenWhen: (previous, current) =>
          previous.stateStatus != current.stateStatus &&
          current.stateStatus == EditCaseStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditCase(),
    );
  }
}

class EditCase extends StatefulWidget {
  const EditCase({super.key});

  @override
  State<EditCase> createState() => _EditCaseState();
}

class _EditCaseState extends State<EditCase> {
  final PageController controller = PageController();
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNewCase = context.select(
      (EditCaseBloc bloc) => bloc.state.isNewCase,
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          isNewCase ? "Add New Case" : "Edit Case",
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
          child: Form(
            key: formKey,
            child: PageView(
              controller: controller,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Case Details : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CaseNumberField(),
                      const CaseActNumberField(),
                      const CaseTypeField(),
                      const CaseSubTypeField(),
                      const DescriptionField(),
                      const SizedBox(
                        height: 10,
                      ),
                      const CaseStatusDropdown(),
                      const SizedBox(
                        height: 10,
                      ),
                      const CaseStageDropdown(),
                      const SizedBox(
                        height: 10,
                      ),
                      const CaseSeverityDropdown(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const FilingDatePicker(),
                      const SizedBox(
                        height: 20,
                      ),
                      const FirstHearingDatePicker(),
                      const SizedBox(
                        height: 20,
                      ),
                      const NextHearingDatePicker(),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: Durations.extralong1,
                                  curve: Curves.easeOut);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Client Details : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ClientNameField(),
                      const ClientContactNumber(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Respondent Details : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const RespondentNameField(),
                      const RespondentContactNumber(),
                      const RespondentSeniorAdvocateNameField(),
                      const RespondentJuniorAdvocateOneNameField(),
                      const RespondentJuniorAdvocateTwoNameField(),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: Durations.extralong1,
                                  curve: Curves.easeOut);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: const Text(
                              "Next",
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Police Station Details : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const PoliceStationTextField(),
                      const FIRNumberTextField(),
                      const FIRDatePicker(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Court Details : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CourtNameTextField(),
                      const CourtNumberTextField(),
                      const SizedBox(
                        height: 10,
                      ),
                      const CourtTypeDropdown(),
                      const SizedBox(
                        height: 20,
                      ),
                      const JudgeNameTextField(),
                      const JudgePostTextField(),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: Durations.extralong1,
                                  curve: Curves.easeOut);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: const Text(
                              "Next",
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Upload Documents :",
                        style: TextStyle(fontSize: 20),
                      ),
                      BlocBuilder<EditCaseBloc, EditCaseState>(
                        buildWhen: (previous, current) =>
                            previous.fileList.length != current.fileList.length,
                        builder: (context, state) {
                          return const UploadFileList();
                        },
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ["pdf"]).then((result) {
                                if (result != null) {
                                  for (PlatformFile file in result.files) {
                                    context
                                        .read<EditCaseBloc>()
                                        .add(EditCaseAddFile(file.path!));
                                  }
                                } else {}
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).indicatorColor),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload Files",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<EditCaseBloc>()
                                    .add(const EditCaseSubmitted());
                                if (!isNewCase) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
