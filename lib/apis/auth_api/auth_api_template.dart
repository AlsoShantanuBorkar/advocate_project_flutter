abstract class AbstractAuthAPI {
  Future<Map<String, dynamic>> login(Map<String, dynamic> data);
  Future<Map<String, dynamic>> signup(Map<String, dynamic> data);
  Future<void> logout();
}
