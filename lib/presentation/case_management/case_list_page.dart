import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_events.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/presentation/case_management/edit_case_page.dart';
import 'package:advocate_project_flutter/presentation/case_management/widgets/case_showcase_tile.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseListPage extends StatelessWidget {
  const CaseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaseListBloc(
        token: context.read<AuthCubit>().state.isLoggedIn
            ? context.read<AuthCubit>().state.user!.token!
            : "",
        casesRepository: context.read<CasesRepository>(),
      )..add(CasesListSubscriptionRequstedEvent()),
      child: const CaseList(),
    );
  }
}

class CaseList extends StatelessWidget {
  const CaseList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      fab: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            EditCasesPage.route(),
          );
        },
      ),
      pageTitle: "Cases",
      body: MultiBlocListener(
        listeners: [
          BlocListener<CaseListBloc, CaseListState>(
            listenWhen: (previous, current) =>
                previous.caseListStatus != current.caseListStatus,
            listener: (context, CaseListState state) {
              if (state.caseListStatus == CaseListStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Operation Failed"),
                    ),
                  );
              }
            },
          ),
          BlocListener<CaseListBloc, CaseListState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedCase != current.lastDeletedCase &&
                current.lastDeletedCase != null,
            listener: (context, state) {
              final Case deletedCase = state.lastDeletedCase!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Text(
                      "Deleted Case : ${deletedCase.caseNumber}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<CaseListBloc>()
                            .add(CasesListUndoDeleteCaseEvent());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<CaseListBloc, CaseListState>(
          builder: (context, state) {
            if (state.caseList.isEmpty) {
              if (state.caseListStatus == CaseListStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.caseListStatus != CaseListStatus.success) {
                return const Center(child: Text("Error Occured"));
              } else {
                return const Center(
                  child: Text(
                    "No Cases Found",
                  ),
                );
              }
            }
            List<Widget> cases = (List.from(state.filteredCases.toList()))
                .map((e) => CaseShowcaseTile(
                      caseModel: e,
                    ))
                .toList();

            return ListView(
              children: cases,
            );
          },
        ),
      ),
    );
  }
}
