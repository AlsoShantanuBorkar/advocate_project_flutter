// ignore_for_file: constant_identifier_names

enum CaseStatus { Open, Pending, Inactive }

extension CaseStatusX on CaseStatus {
  String get name {
    switch (this) {
      case CaseStatus.Open:
        return "Open";
      case CaseStatus.Pending:
        return "Pending";
      case CaseStatus.Inactive:
        return "Inactive";
    }
  }
}

enum CaseStage { Closed, FIR, Pending }

extension CaseStageX on CaseStage {
  String get name {
    switch (this) {
      case CaseStage.Closed:
        return "Closed";
      case CaseStage.FIR:
        return "FIR";
      case CaseStage.Pending:
        return "Pending";
    }
  }
}

enum CaseSeverity { Low, High, Medium }

extension CaseSeverityX on CaseSeverity {
  String get name {
    switch (this) {
      case CaseSeverity.High:
        return "High";
      case CaseSeverity.Medium:
        return "Medium";
      case CaseSeverity.Low:
        return "Low";
    }
  }
}

enum CourtType { DistrictCourt, HighCourt, SupremeCourt }

extension CourtTypeX on CourtType {
  String get name {
    switch (this) {
      case CourtType.HighCourt:
        return "HighCourt";
      case CourtType.SupremeCourt:
        return "SupremeCourt";
      case CourtType.DistrictCourt:
        return "DistrictCourt";
    }
  }
}

enum EditCaseStatus { initial, loading, success, failure }

extension EditCaseStatusX on EditCaseStatus {
  bool get isLoadingOrSuccess => [
        EditCaseStatus.loading,
        EditCaseStatus.success,
      ].contains(this);
}

enum CaseListStatus { init, loading, success, failure }

enum CaseListFilter { all, Pending, Open, Inactive }
