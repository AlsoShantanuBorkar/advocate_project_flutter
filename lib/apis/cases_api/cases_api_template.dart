import 'package:advocate_project_flutter/models/case_model.dart';

abstract class AbstractCaseAPI {
  const AbstractCaseAPI();

  Stream<List<Case>> getCases(
    String token,
  );

  Future<void> saveCase(String token, Case caseModel);

  Future<void> deleteCase(String token, String caseNumber);
}

class CaseNotFoundException implements Exception {}
