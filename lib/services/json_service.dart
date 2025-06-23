import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class JsonService {
  static const _url =
      'http://10.0.2.2:5001/asianlink-b0111/asia-southeast1/v4Api/aj';

  static const _bearerToken =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjNiZjA1MzkxMzk2OTEzYTc4ZWM4MGY0MjcwMzM4NjM2NDA2MTBhZGMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXNpYW5saW5rLWIwMTExIiwiYXVkIjoiYXNpYW5saW5rLWIwMTExIiwiYXV0aF90aW1lIjoxNzUwNjU5MjExLCJ1c2VyX2lkIjoiTGdXMjIyNFVIdWNtSHc3UVVGUEtWY1AzTnhpMiIsInN1YiI6IkxnVzIyMjRVSHVjbUh3N1FVRlBLVmNQM054aTIiLCJpYXQiOjE3NTA2NTkyMTIsImV4cCI6MTc1MDY2MjgxMiwiZW1haWwiOiJpY2UwMzg4NjZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImljZTAzODg2NkBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.X-8fVgXzFMFm0oxQyqtqLrs5ubnEuiAotirxh-3P-7gE-qsPYOI7dlWj_5KU6zkAIlNJX0vtBUbvK7kYT0MndbmR1syBjSybfYYwIDQBaXJQu-SCyQiAt8nLj8fuuPtfA2mRF1TkjkdRl4Fd2dyY0pdNP4pQL59zcz_uG0fuJKF8gQ635-Ce3hrKa8Ayyw2EAcR7EYyTM53zjIuQbZy2luaPna4N_bEz_RCKW7R6HE7Od8vGLmBr3p-DhAfalw-Zb-szyQ8buV4OpQA0NOPxWS_XQfAhysTaoOvfMGN-nbkB_7d8TsvCSHLBjunj9n34zOr4Sn1W2f5ArwEBKWrZeg'; // Replace with your real token

  static Future<Map<String, dynamic>> fetchJson() async {
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: {
          'Authorization': 'Bearer $_bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load JSON (${response.statusCode})');
      }

      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching JSON: $e');
      rethrow;
    }
  }
}
