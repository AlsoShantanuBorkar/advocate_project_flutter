enum EditTeamMemberStateStatus { initial, loading, success, failure }

enum EditTeamMemberStatus { initial, loading, success, failure }

extension EditTeamMemberStatusX on EditTeamMemberStatus {
  bool get isLoadingOrSuccess => [
        EditTeamMemberStatus.loading,
        EditTeamMemberStatus.success,
      ].contains(this);
}

enum TeamMemberListStatus { init, loading, success, failure }
