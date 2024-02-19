import 'dart:convert';
import 'dart:developer';
import 'package:advocate_project_flutter/apis/API_ROUTES.dart';
import 'package:http/http.dart';
import 'package:advocate_project_flutter/apis/auth_api/auth_api_template.dart';
import 'package:advocate_project_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPI extends AbstractAuthAPI {
  final SharedPreferences _sharedPreferencesInstance;

  AuthAPI({required SharedPreferences sharedPreferencesInstance})
      : _sharedPreferencesInstance = sharedPreferencesInstance;

  static const _kCasesCollectionKey = '__user_collection_key__';

  late User? user;

  String? _getValue(String key) =>
      _sharedPreferencesInstance.getString("__user_collection_key__");
  Future<void> _setValue(String value) =>
      _sharedPreferencesInstance.setString("__user_collection_key__", value);

  Future<void> _deleteValue() =>
      _sharedPreferencesInstance.remove("__user_collection_key__");

  bool init() {
    final String? userJson = _getValue(_kCasesCollectionKey);
    if (userJson != null) {
      Map<String, dynamic> json =
          jsonDecode(jsonDecode(userJson)) as Map<String, dynamic>;
      user = User(email: json["email"], token: json["token"]);
      return true;
    } else {
      user = null;
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    Uri uri = Uri.parse(API_ROUTES.login);
    Map<String, dynamic> body = data;

    Response response = await post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    log(response.body);
    Map<String, dynamic> decodedResponse =
        jsonDecode(response.body) as Map<String, dynamic>;
    if (decodedResponse["success"] != null) {
      if (decodedResponse["success"]) {
        user = User(email: data["email"]);
        user!.token = decodedResponse["data"];

        _setValue(jsonEncode(user?.toJson()));
      }
    }
    return decodedResponse;
  }

  @override
  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    Uri uri = Uri.parse(API_ROUTES.register);
    Map<String, dynamic> body = data;

    Response response = await post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});

    Map<String, dynamic> decodedResponse =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (decodedResponse["success"] != null) {
      if (decodedResponse["success"]) {
        user = User.fromMap(data);
        user?.token = decodedResponse["data"];

        _setValue(jsonEncode(user?.toJson()));
      }
    }
    return decodedResponse;
  }

  @override
  Future<void> logout() async {
    _deleteValue();
  }
}
