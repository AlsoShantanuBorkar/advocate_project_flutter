import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_bloc.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_state.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_events.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/presentation/case_management/widgets/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:form_validator/form_validator.dart';

class CaseNumberField extends StatelessWidget {
  const CaseNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.caseNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.caseNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseNumberChanged(value));
      },
    );
  }
}

class CaseTypeField extends StatelessWidget {
  const CaseTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.caseType ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.caseType,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case Type",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseTypeChanged(value));
      },
    );
  }
}

class CaseSubTypeField extends StatelessWidget {
  const CaseSubTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.caseSubtype ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.caseSubtype,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Case SubType",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseSubTypeChanged(value));
      },
    );
  }
}

class CaseStatusDropdown extends StatelessWidget {
  const CaseStatusDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Row(
      children: [
        const Text(
          "Case Status : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<CaseStatus>(
            onSelected: (value) {
              context.read<EditCaseBloc>().add(EditCaseStatusChanged(value!));
            },
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: const BoxConstraints(maxWidth: 150),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            initialSelection: state.caseStatus,
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: CaseStatus.Open,
                label: "Open",
              ),
              DropdownMenuEntry(
                value: CaseStatus.Pending,
                label: "Pending",
              ),
              DropdownMenuEntry(
                value: CaseStatus.Inactive,
                label: "Inactive",
              )
            ]),
      ],
    );
  }
}

class CaseSeverityDropdown extends StatelessWidget {
  const CaseSeverityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Row(
      children: [
        const Text(
          "Case Severity : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<CaseSeverity>(
            onSelected: (value) {
              context.read<EditCaseBloc>().add(EditCaseSeverityChanged(value!));
            },
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                constraints: const BoxConstraints(maxWidth: 150),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            initialSelection: state.caseSeverity,
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: CaseSeverity.High,
                label: "High",
              ),
              DropdownMenuEntry(
                value: CaseSeverity.Low,
                label: "Low",
              ),
              DropdownMenuEntry(
                value: CaseSeverity.Medium,
                label: "Medium",
              )
            ]),
      ],
    );
  }
}

class CaseStageDropdown extends StatelessWidget {
  const CaseStageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Row(
      children: [
        const Text(
          "Case Stage : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<CaseStage>(
          onSelected: (value) {
            context.read<EditCaseBloc>().add(EditCaseStageChanged(value!));
          },
          inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              constraints: const BoxConstraints(maxWidth: 150),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          initialSelection: state.caseStage,
          dropdownMenuEntries: const [
            DropdownMenuEntry(
              value: CaseStage.Pending,
              label: "Pending",
            ),
            DropdownMenuEntry(
              value: CaseStage.Closed,
              label: "Closed",
            ),
            DropdownMenuEntry(
              value: CaseStage.FIR,
              label: "FIR",
            )
          ],
        ),
      ],
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.caseDescription ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.caseDescription,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Description",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseDescriptionChanged(value));
      },
    );
  }
}

class ClientNameField extends StatelessWidget {
  const ClientNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.clientName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.clientName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Client Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseClientNameChanged(value));
      },
    );
  }
}

class ClientContactNumber extends StatelessWidget {
  const ClientContactNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.clientContactNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.clientContactNumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Client Contact Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseClientNumberChanged(value));
      },
    );
  }
}

class RespondentNameField extends StatelessWidget {
  const RespondentNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.respondentName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.respondentName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Respondent Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseRespondentNameChanged(value));
      },
    );
  }
}

class RespondentContactNumber extends StatelessWidget {
  const RespondentContactNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.respondentContactNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.respondentContactNumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Respondent Contact Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditCaseBloc>()
            .add(EditCaseRespondentNumberChanged(value));
      },
    );
  }
}

class RespondentSeniorAdvocateNameField extends StatelessWidget {
  const RespondentSeniorAdvocateNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.respondentSeniorAdvocateName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.respondentSeniorAdvocateName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Senior Advocate",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditCaseBloc>()
            .add(EditCaseRespondentSeniorAdvocateNameChanged(value));
      },
    );
  }
}

class RespondentJuniorAdvocateOneNameField extends StatelessWidget {
  const RespondentJuniorAdvocateOneNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.respondentJuniorAdvocateOneName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.respondentJuniorAdvocateOneName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Junior Advocate One",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditCaseBloc>()
            .add(EditCaseRespondentJuniorAdvocateOneNameChanged(value));
      },
    );
  }
}

class RespondentJuniorAdvocateTwoNameField extends StatelessWidget {
  const RespondentJuniorAdvocateTwoNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.respondentJuniorAdvocateTwoName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.respondentJuniorAdvocateTwoName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Junior Advocate Two",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditCaseBloc>()
            .add(EditCaseRespondentJuniorAdvocateTwoNameChanged(value));
      },
    );
  }
}

class CaseActNumberField extends StatelessWidget {
  const CaseActNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.actNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.actNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Act Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseActNumberChanged(value));
      },
    );
  }
}

class FilingDatePicker extends StatelessWidget {
  const FilingDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Text(
            "Filing Date :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then(
                      (value) {
                        if (value != null) {
                          context
                              .read<EditCaseBloc>()
                              .add(EditCaseFilingDateChanged(value));
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(state.FIRdate.toIso8601String().substring(0, 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirstHearingDatePicker extends StatelessWidget {
  const FirstHearingDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Text(
            "First Hearing Date :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        context
                            .read<EditCaseBloc>()
                            .add(EditCaseFirstHearingDateChanged(value));
                      }
                    });
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(state.FIRdate.toIso8601String().substring(0, 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextHearingDatePicker extends StatelessWidget {
  const NextHearingDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Text(
            "Next Hearing Date :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        context
                            .read<EditCaseBloc>()
                            .add(EditCaseNextHearingDateChanged(value));
                      }
                    });
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(state.FIRdate.toIso8601String().substring(0, 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PoliceStationTextField extends StatelessWidget {
  const PoliceStationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.policeStation ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.policeStation,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Police Station Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCasePoliceStationChanged(value));
      },
    );
  }
}

class FIRNumberTextField extends StatelessWidget {
  const FIRNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.FIRnumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.FIRnumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "FIR Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseFIRnumberChanged(value));
      },
    );
  }
}

class FIRDatePicker extends StatelessWidget {
  const FIRDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Text(
            "FIR Date :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        context
                            .read<EditCaseBloc>()
                            .add(EditCaseFIRDateChanged(value));
                      }
                    });
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(state.FIRdate.toIso8601String().substring(0, 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourtNameTextField extends StatelessWidget {
  const CourtNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.courtName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.courtName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Court Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseCourtNameChanged(value));
      },
    );
  }
}

class CourtNumberTextField extends StatelessWidget {
  const CourtNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.courtNumber ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.courtNumber,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Court Number",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseCourtNumberChanged(value));
      },
    );
  }
}

class CourtTypeDropdown extends StatelessWidget {
  const CourtTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;

    return Row(
      children: [
        const Text(
          "Court Type : ",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownMenu<CourtType>(
            onSelected: (value) {
              context
                  .read<EditCaseBloc>()
                  .add(EditCaseCourtTypeChanged(value!));
            },
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            initialSelection: state.courtType,
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: CourtType.SupremeCourt,
                label: "SupremeCourt",
              ),
              DropdownMenuEntry(
                value: CourtType.HighCourt,
                label: "HighCourt",
              ),
              DropdownMenuEntry(
                value: CourtType.DistrictCourt,
                label: "DistrictCourt",
              )
            ]),
      ],
    );
  }
}

class JudgeNameTextField extends StatelessWidget {
  const JudgeNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.judgeName ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.judgeName,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Judge Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseJudgeNameChanged(value));
      },
    );
  }
}

class JudgePostTextField extends StatelessWidget {
  const JudgePostTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditCaseBloc>().state;
    final hintText = state.initialCase?.judgePost ?? '';

    return TextFormField(
      validator: ValidationBuilder().required().build(),
      cursorColor: Theme.of(context).primaryColor,
      initialValue: state.judgePost,
      decoration: InputDecoration(
          enabled: !state.stateStatus.isLoadingOrSuccess,
          hintText: hintText,
          labelText: "Judge Post",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: const OutlineInputBorder()),
      maxLength: 20,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      onChanged: (value) {
        context.read<EditCaseBloc>().add(EditCaseJudgePostChanged(value));
      },
    );
  }
}

class UploadFileList extends StatefulWidget {
  const UploadFileList({super.key});

  @override
  State<UploadFileList> createState() => _UploadFileListState();
}

class _UploadFileListState extends State<UploadFileList> {
  final FocusNode buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCaseBloc, EditCaseState>(
      buildWhen: (previous, current) =>
          previous.fileList.length != current.fileList.length,
      builder: (context, state) {
        List<Widget> fileWidgets = List.generate(
            state.fileList.length,
            (index) => SizedBox(
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 200,
                          child: PDFView(
                            fitEachPage: false,
                            enableSwipe: false,
                            filePath: state.fileList[index]["path"],
                            fitPolicy: FitPolicy.WIDTH,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                    path: state.fileList[index]["path"]),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 200,
                            color: Colors.transparent,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle),
                            child: MenuAnchor(
                              childFocusNode: buttonFocusNode,
                              style: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                surfaceTintColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              menuChildren: [
                                MenuItemButton(
                                  onPressed: () {
                                    context.read<EditCaseBloc>().add(
                                        EditCaseRemoveFile(
                                            state.fileList[index]["path"]));
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: const Text("Delete"),
                                  ),
                                ),
                                SubmenuButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.white),
                                      surfaceTintColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.white),
                                    ),
                                    menuChildren: [
                                      MenuItemButton(
                                          onPressed: () {
                                            context.read<EditCaseBloc>().add(
                                                  EditCaseFileTagChange(
                                                      filePath:
                                                          state.fileList[index]
                                                              ["path"],
                                                      filetag: "Sales Deed"),
                                                );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                              state.fileList[index]["tag"] ==
                                                      "Sales Deed"
                                                  ? Colors.grey.shade100
                                                  : Colors.white,
                                            ),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Colors.white),
                                          ),
                                          child: const Text(
                                            "Sales Deed",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      MenuItemButton(
                                          onPressed: () {
                                            context.read<EditCaseBloc>().add(
                                                  EditCaseFileTagChange(
                                                      filePath:
                                                          state.fileList[index]
                                                              ["path"],
                                                      filetag: "Tax Invoice"),
                                                );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                              state.fileList[index]["tag"] ==
                                                      "Tax Invoice"
                                                  ? Colors.grey.shade100
                                                  : Colors.white,
                                            ),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Colors.white),
                                          ),
                                          child: const Text(
                                            "Tax Invoice",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      MenuItemButton(
                                          onPressed: () {
                                            context.read<EditCaseBloc>().add(
                                                  EditCaseFileTagChange(
                                                    filePath:
                                                        state.fileList[index]
                                                            ["path"],
                                                    filetag: "Property Deed",
                                                  ),
                                                );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                              state.fileList[index]["tag"] ==
                                                      "Property Deed"
                                                  ? Colors.grey.shade100
                                                  : Colors.white,
                                            ),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Colors.white),
                                          ),
                                          child: const Text("Property Deed",
                                              style: TextStyle(
                                                  color: Colors.black))),
                                    ],
                                    child: const Text(
                                      "Document Type",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                              child: const Icon(Icons.menu),
                              builder: (BuildContext context,
                                  MenuController controller, Widget? child) {
                                return TextButton(
                                  focusNode: buttonFocusNode,
                                  onPressed: () {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width / 3,
                        //     height: 40,
                        //     child: ElevatedButton(
                        //       onPressed: () {},
                        //       style: ElevatedButton.styleFrom(
                        //           backgroundColor:
                        //               Theme.of(context).primaryColor),
                        //       child: const Text(
                        //         "Submit",
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ));

        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 250, crossAxisCount: 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: fileWidgets,
        );
      },
    );
  }
}
