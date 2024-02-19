import 'package:advocate_project_flutter/apis/auth_api/auth_api.dart';
import 'package:advocate_project_flutter/models/user_model.dart';

class AuthRepository {
  final AuthAPI _authAPI;

  AuthRepository({required AuthAPI authAPI}) : _authAPI = authAPI;

  User? get user => _authAPI.user;

  bool init() => _authAPI.init();

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> data) =>
      _authAPI.login(data);

  Future<Map<String, dynamic>> signupUser(Map<String, dynamic> data) =>
      _authAPI.signup(data);

  Future<void> logout() => _authAPI.logout();
}
