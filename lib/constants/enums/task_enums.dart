// ignore_for_file: constant_identifier_names

enum TaskStatus { OPEN, PENDING, INACTIVE }

extension TaskStatusX on TaskStatus {
  String get name {
    switch (this) {
      case TaskStatus.OPEN:
        return "OPEN";
      case TaskStatus.PENDING:
        return "PENDING";
      case TaskStatus.INACTIVE:
        return "INACTIVE";
    }
  }
}

enum TaskPriority { HIGH, LOW, MEDIUM }

extension TaskPriorityX on TaskPriority {
  String get name {
    switch (this) {
      case TaskPriority.HIGH:
        return "HIGH";
      case TaskPriority.LOW:
        return "LOW";
      case TaskPriority.MEDIUM:
        return "MEDIUM";
    }
  }
}

enum EditTaskStatus { initial, loading, success, failure }

extension EditTaskStatusX on EditTaskStatus {
  bool get isLoadingOrSuccess => [
        EditTaskStatus.loading,
        EditTaskStatus.success,
      ].contains(this);
}

enum TaskListStatus { init, loading, success, failure }

enum TaskListFilter { ALL, PENDING, OPEN, INACTIVE }
