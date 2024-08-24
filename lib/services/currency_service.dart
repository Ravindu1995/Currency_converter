import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CurrencyService {
  final Dio _dio;

  CurrencyService(this._dio);

  final String _baseUrl = 'https://v6.exchangerate-api.com/v6/';
  final String _apiKey = '4139595759b8d768c0ef35a5';

  Future<Map<String, dynamic>> fetchLatestRates(String baseCurrency) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/$_apiKey/latest/$baseCurrency',
      );

      return response.data['conversion_rates'];
    } catch (e) {
      debugPrint('Error fetching latest rates: $e');
      throw Exception('Failed to load exchange rates');
    }
  }
}
