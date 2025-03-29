import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_ocr/core/constants/api_constants.dart';
import 'package:smart_ocr/core/services/error_service.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/domain/models/error_model.dart';

/// API istek sonucu
class ApiResponse<T> {
  /// Constructor
  ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  /// İşlem başarılı mı
  final bool success;

  /// Yanıt verisi
  final T? data;

  /// Hata
  final ErrorModel? error;

  /// HTTP durum kodu
  final int? statusCode;
}

/// API istek servisi
class ApiService {
  /// Factory constructor
  factory ApiService() => _instance;

  /// Internal constructor
  ApiService._internal();

  /// Singleton instance
  static final ApiService _instance = ApiService._internal();

  /// HTTP client
  final _client = http.Client();

  /// Logger servisi
  final _logger = LoggerService();

  /// Hata servisi
  final _errorService = ErrorService();

  /// GET isteği
  Future<ApiResponse<T>> get<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? apiKey,
    int? timeout,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final requestHeaders = _buildHeaders(headers, apiKey);

      _logger
        ..d('GET isteği: $uri')
        ..d('Headers: $requestHeaders');

      final response = await _client.get(uri, headers: requestHeaders).timeout(
            Duration(milliseconds: timeout ?? ApiConstants.requestTimeout),
          );

      return _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İnternet bağlantısı bulunamadı',
          stackTrace: StackTrace.current,
        ),
      );
    } on HttpException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: e.message,
          stackTrace: stackTrace,
        ),
      );
    } on TimeoutException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İstek zaman aşımına uğradı: ${e.message}',
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'GET isteği sırasında hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// POST isteği
  Future<ApiResponse<T>> post<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    String? apiKey,
    int? timeout,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final requestHeaders = _buildHeaders(headers, apiKey);
      final encodedBody = body != null ? jsonEncode(body) : null;

      _logger
        ..d('POST isteği: $uri')
        ..d('Headers: $requestHeaders')
        ..d('Body: $encodedBody');

      final response = await _client
          .post(uri, headers: requestHeaders, body: encodedBody)
          .timeout(
            Duration(milliseconds: timeout ?? ApiConstants.requestTimeout),
          );

      return _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İnternet bağlantısı bulunamadı',
          stackTrace: StackTrace.current,
        ),
      );
    } on HttpException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: e.message,
          stackTrace: stackTrace,
        ),
      );
    } on TimeoutException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İstek zaman aşımına uğradı: ${e.message}',
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'POST isteği sırasında hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// PUT isteği
  Future<ApiResponse<T>> put<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    String? apiKey,
    int? timeout,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final requestHeaders = _buildHeaders(headers, apiKey);
      final encodedBody = body != null ? jsonEncode(body) : null;

      _logger
        ..d('PUT isteği: $uri')
        ..d('Headers: $requestHeaders')
        ..d('Body: $encodedBody');

      final response = await _client
          .put(uri, headers: requestHeaders, body: encodedBody)
          .timeout(
            Duration(milliseconds: timeout ?? ApiConstants.requestTimeout),
          );

      return _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İnternet bağlantısı bulunamadı',
          stackTrace: StackTrace.current,
        ),
      );
    } on HttpException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: e.message,
          stackTrace: stackTrace,
        ),
      );
    } on TimeoutException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İstek zaman aşımına uğradı: ${e.message}',
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'PUT isteği sırasında hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// DELETE isteği
  Future<ApiResponse<T>> delete<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    String? apiKey,
    int? timeout,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final requestHeaders = _buildHeaders(headers, apiKey);

      _logger
        ..d('DELETE isteği: $uri')
        ..d('Headers: $requestHeaders');

      final response =
          await _client.delete(uri, headers: requestHeaders).timeout(
                Duration(milliseconds: timeout ?? ApiConstants.requestTimeout),
              );

      return _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İnternet bağlantısı bulunamadı',
          stackTrace: StackTrace.current,
        ),
      );
    } on HttpException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: e.message,
          stackTrace: stackTrace,
        ),
      );
    } on TimeoutException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İstek zaman aşımına uğradı: ${e.message}',
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'DELETE isteği sırasında hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// PATCH isteği
  Future<ApiResponse<T>> patch<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    String? apiKey,
    int? timeout,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final requestHeaders = _buildHeaders(headers, apiKey);
      final encodedBody = body != null ? jsonEncode(body) : null;

      _logger
        ..d('PATCH isteği: $uri')
        ..d('Headers: $requestHeaders')
        ..d('Body: $encodedBody');

      final response = await _client
          .patch(uri, headers: requestHeaders, body: encodedBody)
          .timeout(
            Duration(milliseconds: timeout ?? ApiConstants.requestTimeout),
          );

      return _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İnternet bağlantısı bulunamadı',
          stackTrace: StackTrace.current,
        ),
      );
    } on HttpException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: e.message,
          stackTrace: stackTrace,
        ),
      );
    } on TimeoutException catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createNetworkError(
          message: 'İstek zaman aşımına uğradı: ${e.message}',
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'PATCH isteği sırasında hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Yanıtı işle
  ApiResponse<T> _handleResponse<T>(http.Response response) {
    try {
      _logger
        ..d('Yanıt durum kodu: ${response.statusCode}')
        ..d('Yanıt gövdesi: ${response.body}');

      final statusCode = response.statusCode;
      final responseBody = response.body;

      if (statusCode >= 200 && statusCode < 300) {
        // Başarılı yanıt
        if (responseBody.isEmpty) {
          return ApiResponse<T>(
            success: true,
            statusCode: statusCode,
          );
        }

        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return ApiResponse<T>(
          success: true,
          data: jsonResponse as T,
          statusCode: statusCode,
        );
      } else {
        // Hata yanıtı
        String errorMessage;
        try {
          final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
          errorMessage = jsonResponse['message'] as String? ??
              jsonResponse['error'] as String? ??
              'Bilinmeyen hata';
        } catch (e) {
          errorMessage = responseBody.isNotEmpty
              ? responseBody
              : 'HTTP hata kodu: $statusCode';
        }

        return ApiResponse<T>(
          success: false,
          error: _errorService.createNetworkError(
            message: errorMessage,
            stackTrace: StackTrace.current,
          ),
          statusCode: statusCode,
        );
      }
    } catch (e, stackTrace) {
      return ApiResponse<T>(
        success: false,
        error: _errorService.createUnexpectedError(
          message: 'Yanıt işlenirken hata oluştu: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// URI oluştur
  Uri _buildUri(String url, Map<String, dynamic>? queryParameters) {
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return Uri.parse(url).replace(
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );
    }
    return Uri.parse(url);
  }

  /// İstek başlıklarını oluştur
  Map<String, String> _buildHeaders(
    Map<String, String>? headers,
    String? apiKey,
  ) {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    if (apiKey != null && apiKey.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $apiKey';
    }

    return requestHeaders;
  }
}
