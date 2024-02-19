import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:equatable/equatable.dart';

class CaseListState extends Equatable {
  const CaseListState({
    this.caseListStatus = CaseListStatus.init,
    this.caseList = const [],
    this.caseListFilter = CaseListFilter.all,
    this.lastDeletedCase,
  });

  final CaseListStatus caseListStatus;
  final List<Case> caseList;
  final CaseListFilter caseListFilter;
  final Case? lastDeletedCase;

  Iterable<Case> get filteredCases {
    if (caseListFilter == CaseListFilter.all) {
      return caseList;
    } else if (caseListFilter == CaseListFilter.Open) {
      return caseList
          .where((element) => element.caseStatus == CaseStatus.Pending);
    } else if (caseListFilter == CaseListFilter.Open) {
      return caseList.where((element) => element.caseStatus == CaseStatus.Open);
    } else {
      return caseList
          .where((element) => element.caseStatus == CaseStatus.Inactive);
    }
  }

  CaseListState copyWith({
    CaseListStatus? caseListStatus,
    List<Case>? caseList,
    CaseListFilter? caseListFilter,
    Case? lastDeletedCase,
  }) {
    return CaseListState(
      caseListStatus: caseListStatus ?? this.caseListStatus,
      caseList: caseList ?? this.caseList,
      caseListFilter: caseListFilter ?? this.caseListFilter,
      lastDeletedCase: lastDeletedCase ?? this.lastDeletedCase,
    );
  }

  @override
  List<Object?> get props =>
      [caseListStatus, caseList, caseListFilter, lastDeletedCase];
}
