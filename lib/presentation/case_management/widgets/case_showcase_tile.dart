import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_events.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/presentation/case_management/case_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseShowcaseTile extends StatelessWidget {
  const CaseShowcaseTile({
    super.key,
    required this.caseModel,
  });
  final Case caseModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.black,
        elevation: 1,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              CaseDetailsPage.route(
                  caseModel: caseModel,
                  onDelete: () {
                    context.read<CaseListBloc>().add(
                          CasesListDeleteCaseEvent(
                            caseModel: caseModel,
                          ),
                        );
                  }),
            );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          tileColor: Colors.white,
          leading: Text(
            "#${caseModel.caseNumber}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Chip(
            label: Text(
              caseModel.caseStatus.name,
              style: TextStyle(
                fontSize: 12,
                color: caseModel.caseStatus == CaseStatus.Open
                    ? Colors.indigo
                    : caseModel.caseStatus == CaseStatus.Inactive
                        ? Colors.red
                        : Colors.green,
              ),
            ),
            backgroundColor: caseModel.caseStatus == CaseStatus.Open
                ? Colors.indigo.shade50
                : caseModel.caseStatus == CaseStatus.Inactive
                    ? Colors.red.shade50
                    : Colors.green.shade50,
            side: BorderSide.none,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          horizontalTitleGap: 10,
          title: Text(
            caseModel.clientName,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            DateTime.now().toIso8601String().substring(0, 10),
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
