import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:main/services/base/dio_client.dart';
import 'package:main/utils/constant/app_constant.dart';

class JsonService {
  static Future<Map<String, dynamic>> fetchJson() async {
    try {
      final response = await DioClient().get(
        AppConstant.da_json_screen,
        bearerToken: "",
      );

      return response.data is Map<String, dynamic>
          ? response.data
          : json.decode(response.data) as Map<String, dynamic>;
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Failed to fetch JSON from Dio');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchJsonDynamic() async {
    try {
      final response = await DioClient().get(
        AppConstant.da_test2,
        bearerToken: "", // Set token if needed
      );

      return response.data is Map<String, dynamic>
          ? response.data
          : json.decode(response.data) as Map<String, dynamic>;
    } on DioException catch (e) {
      debugPrint('❌ Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Failed to fetch JSON from Dio');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      rethrow;
    }
  }
}
