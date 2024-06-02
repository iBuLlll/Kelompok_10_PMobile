import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';

  static Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<Map<String, dynamic>> fetchUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load user details');
    }
  }

  static Future<void> addUser(
      String firstName, String lastName, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }
}
