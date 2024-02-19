enum ScheduleEventListStateStatus { initial, loading, success, failure }

enum EditScheduleEventStatus { initial, loading, success, failure }

extension EditCaseStatusX on EditScheduleEventStatus {
  bool get isLoadingOrSuccess => [
        EditScheduleEventStatus.loading,
        EditScheduleEventStatus.success,
      ].contains(this);
}
