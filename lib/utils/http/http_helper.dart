import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl = 'http://192.168.31.5:8000';

  static Map<String, String> _getHeaders({bool isForm = false}) {
    final box = GetStorage();
    final token = box.read('access_token');

    return {
      'Content-Type': isForm
          ? 'application/x-www-form-urlencoded'
          : 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(),
    );
    return _handleResponse(response);
  }

  static Future<void> post(String endpoint, dynamic data) async {
    await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(),
      body: json.encode(data),
    );
  }

  static Future<Map<String, dynamic>> postForm(
    String endpoint,
    Map<String, String> data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(isForm: true),
      body: data,
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(),
      body: json.encode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty
          ? json.decode(response.body)
          : {}; // бос болса, бос Map қайтар
    } else {
      throw Exception('Қате статус код: ${response.statusCode}');
    }
  }

  static Future<void> delete(String endpoint) async {
    await http.delete(Uri.parse('$_baseUrl/$endpoint'), headers: _getHeaders());
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final errorBody = response.body.isNotEmpty
          ? response.body
          : 'No error message';
      throw Exception(
        'Failed to load data: ${response.statusCode}\n$errorBody',
      );
    }
  }

  static Future<List<dynamic>> getList(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception(
        'Failed to load list: ${response.statusCode}\n${response.body}',
      );
    }
  }
}
