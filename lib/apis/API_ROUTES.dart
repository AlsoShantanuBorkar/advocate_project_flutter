class API_ROUTES {
  static const String baseURL = "http://localhost:3000/api/v1";
  static const String register = "$baseURL/register";
  static const String login = "$baseURL/login";
  static const String me = "$baseURL/me";
  static const String allUsers = "$baseURL/getusers";
  static const String allCases = "$baseURL/case";
  static const String putCase = "$baseURL/case";
  static const String deleteCase = "$baseURL/case/";
  static const String getTasks = "$baseURL/task";
  static const String putTasks = "$baseURL/task";
  static const String deleteCases = "$baseURL/task/";
}
