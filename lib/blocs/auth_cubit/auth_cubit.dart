import 'dart:developer';
import 'package:advocate_project_flutter/blocs/auth_cubit/auth_state.dart';
import 'package:advocate_project_flutter/models/user_model.dart';
import 'package:advocate_project_flutter/presentation/user_auth_management/login_page.dart';
import 'package:advocate_project_flutter/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final BuildContext context;
  AuthCubit({
    required this.authRepository,
    required this.context,
  }) : super(AuthState(isLoggedIn: false, isLoading: true, user: null)) {
    bool value = authRepository.init();

    if (value) {
      emit(state.copyWith(
          isLoading: false, isLoggedIn: true, user: authRepository.user));
    } else {
      emit(state.copyWith(
          isLoading: false, isLoggedIn: false, user: authRepository.user));
    }
  }

  Future<void> onLogout(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    authRepository.logout();
    emit(state.copyWith(isLoading: false, isLoggedIn: false, user: null));
  }

  Future<void> onSignup(
    Map<String, dynamic> signupData,
  ) async {
    emit(state.copyWith(isLoading: true));
    Map<String, dynamic> data = signupData;

    log(state.user.toString());
    await authRepository.signupUser(data).then((response) {
      log(response.toString());
      if (response["success"] == true) {
        data["token"] = response["data"];
        User user = User.fromMap(data);
        log(user.toString());
        emit(state.copyWith(isLoading: false, isLoggedIn: true, user: user));
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Occured"),
          ),
        );
        emit(state.copyWith(isLoading: false, isLoggedIn: false));
      }
      emit(state.copyWith(isLoading: false, isLoggedIn: false));
    });
  }

  Future<void> onLogin(
    Map<String, dynamic> loginData,
  ) async {
    emit(state.copyWith(isLoading: true));
    Map<String, dynamic> data = loginData;
    await authRepository.loginUser(data).then((response) {
      if (response["success"] == true) {
        data["token"] = response["data"];
        User user = User(email: data["email"], token: response["data"]);

        emit(state.copyWith(isLoading: false, isLoggedIn: true, user: user));
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text("Error Occured"),
          ),
        );
        emit(state.copyWith(isLoading: false, isLoggedIn: false));
      }
      emit(state.copyWith(isLoading: false, isLoggedIn: false));
    });
  }
}
