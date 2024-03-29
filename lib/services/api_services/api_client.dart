import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:norq_ecom/utils/console_log.dart';

class ApiClient {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Function to handle HTTP GET request
  Future getRequest(String endpoint) async {
    try {
      final String url = baseUrl + endpoint;
      consoleLog("[API_REQUEST] sending reqeust to: $url");
      final response = await http.get(Uri.parse(url));
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Function to handle HTTP POST request
  Future<Map<String, dynamic>> postRequest(
      String endpoint, dynamic data) async {
    try {
      final String url = baseUrl + endpoint;
      consoleLog(
          "[API_REQUEST] sending reqeust to: $url  \n request_body: $data");
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Function to handle HTTP PUT request
  Future<Map<String, dynamic>> putRequest(String endpoint, dynamic data) async {
    try {
      final String url = baseUrl + endpoint;
      consoleLog(
          "[API_REQUEST] sending reqeust to: $url  \n request_body: $data");
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Function to handle HTTP DELETE request
  Future<Map<String, dynamic>> deleteRequest(String endpoint) async {
    try {
      final String url = baseUrl + endpoint;
      consoleLog("[API_REQUEST] sending reqeust to: $url");
      final response = await http.delete(Uri.parse(url));
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Function to handle HTTP response
  _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      consoleLog(
          "[API_RESPONSE] \n status_code: ${response.statusCode} response_body: ${response.body}");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
