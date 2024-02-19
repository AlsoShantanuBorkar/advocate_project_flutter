import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:equatable/equatable.dart';

abstract class CaseListEvent extends Equatable {}

class CasesListSubscriptionRequstedEvent extends CaseListEvent {
  CasesListSubscriptionRequstedEvent();

  @override
  List<Object> get props => [];
}

class CasesListDeleteCaseEvent extends CaseListEvent {
  CasesListDeleteCaseEvent({required this.caseModel});

  final Case caseModel;

  @override
  List<Object> get props => [caseModel];
}

class CasesListUndoDeleteCaseEvent extends CaseListEvent {
  CasesListUndoDeleteCaseEvent();

  @override
  List<Object> get props => [];
}

class CasesListChangeCaseFilterEvent extends CaseListEvent {
  CasesListChangeCaseFilterEvent({required this.caseModelListFilter});

  final CaseListFilter caseModelListFilter;

  @override
  List<Object> get props => [];
}
