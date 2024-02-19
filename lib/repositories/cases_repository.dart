import 'package:advocate_project_flutter/apis/cases_api/cases_api.dart';
import 'package:advocate_project_flutter/models/case_model.dart';

class CasesRepository {
  const CasesRepository({
    required CaseAPI caseAPI,
  }) : _caseAPI = caseAPI;

  final CaseAPI _caseAPI;

  Stream<List<Case>> getCases(
    String token,
  ) =>
      _caseAPI.getCases(token);

  Future<bool> saveCase(String token, Case record) =>
      _caseAPI.saveCase(token, record);

  Future<void> deleteCase(String token, String id) =>
      _caseAPI.deleteCase(token, id);
}
