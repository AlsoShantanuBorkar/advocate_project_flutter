import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_events.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseListBloc extends Bloc<CaseListEvent, CaseListState> {
  final CasesRepository _casesRepository;
  final String token;
  CaseListBloc({required CasesRepository casesRepository, this.token = ""})
      : _casesRepository = casesRepository,
        super(const CaseListState()) {
    on<CasesListSubscriptionRequstedEvent>(
        _onCasesListSubscriptionRequstedEvent);
    on<CasesListDeleteCaseEvent>(_onCasesListDeleteCaseEvent);
    on<CasesListUndoDeleteCaseEvent>(_onCasesListUndoDeleteCase);
    on<CasesListChangeCaseFilterEvent>(_onCasesListChangeCaseFilter);
  }

  Future<void> _onCasesListSubscriptionRequstedEvent(
    CasesListSubscriptionRequstedEvent event,
    Emitter<CaseListState> emit,
  ) async {
    emit(state.copyWith(caseListStatus: CaseListStatus.init));

    await emit.forEach<List<Case>>(
      _casesRepository.getCases(
        token,
      ),
      onData: (caseModelList) => state.copyWith(
        caseListStatus: CaseListStatus.success,
        caseList: caseModelList,
      ),
      onError: (_, __) => state.copyWith(
        caseListStatus: CaseListStatus.failure,
      ),
    );
  }

  Future<void> _onCasesListDeleteCaseEvent(
    CasesListDeleteCaseEvent event,
    Emitter<CaseListState> emit,
  ) async {
    emit(state.copyWith(lastDeletedCase: event.caseModel));
    await _casesRepository.deleteCase(token, event.caseModel.caseNumber);
  }

  Future<void> _onCasesListUndoDeleteCase(
    CasesListUndoDeleteCaseEvent event,
    Emitter<CaseListState> emit,
  ) async {
    assert(
      state.lastDeletedCase != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedCase!;
    emit(state.copyWith(lastDeletedCase: null));
    await _casesRepository.saveCase(token, todo);
  }

  Future<void> _onCasesListChangeCaseFilter(
    CasesListChangeCaseFilterEvent event,
    Emitter<CaseListState> emit,
  ) async {
    emit(state.copyWith(caseListFilter: event.caseModelListFilter));
  }
}
