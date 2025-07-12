import 'dart:convert';
import 'package:ezycourse/core/constants/string_constant.dart';
import 'package:ezycourse/data/local/shared_prefs.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static const String baseUrl = 'https://ezyappteam.ezycourse.com/api/app/';

  Future<dynamic> post(String endpoint,
      Map<String, dynamic> body) async {
    String token = SharedPrefs.getString(StringConstants.token);
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //log("API Response: $data");
      return data;
    } else {
      throw Exception(data['message'] ?? 'Task failed');
    }
  }



}