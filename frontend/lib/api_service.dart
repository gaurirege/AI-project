import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class ApiService {
  static Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {"success": true, "data": data};
      } else {
        return {"success": false, "message": data["detail"] ?? "Signup failed"};
      }
    } catch (e) {
      return {"success": false, "message": "Connection error: $e"};
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {"success": true, "data": data};
      } else {
        return {"success": false, "message": data["detail"] ?? "Login failed"};
      }
    } catch (e) {
      return {"success": false, "message": "Connection error: $e"};
    }
  }
}
