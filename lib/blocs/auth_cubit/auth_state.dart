import 'package:equatable/equatable.dart';

import 'package:advocate_project_flutter/models/user_model.dart';

class AuthState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  final User? user;

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    required this.user,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    User? user,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isLoggedIn,
        isLoading,
        user,
      ];
}
