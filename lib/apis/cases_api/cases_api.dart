import 'dart:async';
import 'dart:convert';
import 'package:advocate_project_flutter/apis/API_ROUTES.dart';
import 'package:advocate_project_flutter/apis/cases_api/cases_api_template.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CaseAPI extends AbstractCaseAPI {
  final Dio dio = Dio();
  CaseAPI({
    required SharedPreferences sharedPreferencesIntsance,
  }) : _sharedPreferencesIntsance = sharedPreferencesIntsance {
    _init();
  }

  final SharedPreferences _sharedPreferencesIntsance;

  final BehaviorSubject<List<Case>> _caseStreamController =
      BehaviorSubject<List<Case>>.seeded(const []);

  static const _kCasesCollectionKey = '__records_collection_key__';

  String? _getValue(String key) => _sharedPreferencesIntsance.getString(key);
  Future<void> _setValue(String key, String value) =>
      _sharedPreferencesIntsance.setString(key, value);

  void _init() {
    final String? casesJson = _getValue(_kCasesCollectionKey);
    if (casesJson != null) {
      List x = jsonDecode(casesJson);
      List<Case> cases = x.map((e) => Case.fromJson(e)).toList();
      _caseStreamController.add(cases);
    } else {
      _caseStreamController.add(const []);
    }
  }

  Future<void> fetchCases(String token) async {
    try {
      Uri uri = Uri.parse("http://localhost:3000/api/v1/case");
      http.Response response = await http.get(uri, headers: {"token": token});
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> decodedResponse =
            (jsonDecode(response.body) as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
        final List<Case> cases = [..._caseStreamController.value];
        decodedResponse.forEach((element) {
          Case caseModel = Case.fromMap(element);
          int index = cases.indexWhere(
              (element) => element.caseNumber == caseModel.caseNumber);
          if (index != -1) {
            cases[index] = caseModel;
          } else {
            cases.add(caseModel);
          }
        });
        _caseStreamController.add(cases);
        return _setValue(_kCasesCollectionKey, json.encode(cases));
      } else {}
    } catch (e) {}
  }

  @override
  Stream<List<Case>> getCases(String token) {
    fetchCases(token);
    return _caseStreamController.asBroadcastStream();
  }

  @override
  Future<bool> saveCase(String token, Case caseModel) async {
    try {
      Uri uri = Uri.parse(API_ROUTES.putCase);
      Response response = await dio.postUri(uri,
          data: caseModel.toJson(),
          options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        final cases = [..._caseStreamController.value];
        final caseModelIndex =
            cases.indexWhere((t) => t.caseNumber == caseModel.caseNumber);
        if (caseModelIndex >= 0) {
          cases[caseModelIndex] = caseModel;
        } else {
          cases.add(caseModel);
        }
        _caseStreamController.add(cases);
        _setValue(_kCasesCollectionKey, json.encode(cases));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteCase(String token, String caseNumber) async {
    try {
      Uri uri = Uri.parse(API_ROUTES.deleteCase + caseNumber);
      http.Response response =
          await http.delete(uri, headers: {"token": token});
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}

    final cases = [..._caseStreamController.value];
    final recordIndex = cases.indexWhere((t) => t.caseNumber == caseNumber);
    if (recordIndex == -1) {
      throw CaseNotFoundException();
    } else {
      cases.removeAt(recordIndex);
      _caseStreamController.add(cases);
      return _setValue(_kCasesCollectionKey, json.encode(cases));
    }
  }
}
