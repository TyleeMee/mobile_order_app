import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';

  // トークン付きでのリクエスト
  // static Future<dynamic> fetchWithAuth(
  //   String endpoint,
  //   String? token, {
  //   String method = 'GET',
  //   dynamic body,
  //   Map<String, String>? additionalHeaders,
  // }) async {
  //   if (token == null || token.isEmpty) {
  //     throw Exception('認証トークンが取得できませんでした');
  //   }

  //   final uri = Uri.parse('$apiBaseUrl$endpoint');
  //   final headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //     ...?additionalHeaders,
  //   };

  //   http.Response response;

  //   try {
  //     switch (method) {
  //       case 'GET':
  //         response = await http.get(uri, headers: headers);
  //         break;
  //       case 'POST':
  //         response = await http.post(
  //           uri,
  //           headers: headers,
  //           body: body != null ? jsonEncode(body) : null,
  //         );
  //         break;
  //       case 'PUT':
  //         response = await http.put(
  //           uri,
  //           headers: headers,
  //           body: body != null ? jsonEncode(body) : null,
  //         );
  //         break;
  //       case 'DELETE':
  //         response = await http.delete(
  //           uri,
  //           headers: headers,
  //           body: body != null ? jsonEncode(body) : null,
  //         );
  //         break;
  //       default:
  //         throw Exception('サポートされていないHTTPメソッド: $method');
  //     }

  //     if (response.statusCode < 200 || response.statusCode >= 300) {
  //       throw Exception('APIエラー: ${response.statusCode}');
  //     }

  //     if (response.body.isEmpty) {
  //       return null;
  //     }

  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     throw Exception('リクエストエラー: $e');
  //   }
  // }

  // トークンなしでのリクエスト
  static Future<dynamic> fetch(
    String endpoint, {
    String method = 'GET',
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$apiBaseUrl$endpoint');
    final requestHeaders = {'Content-Type': 'application/json', ...?headers};

    http.Response response;

    try {
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        default:
          throw Exception('サポートされていないHTTPメソッド: $method');
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('APIエラー: ${response.statusCode}');
      }

      if (response.body.isEmpty) {
        return null;
      }

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('リクエストエラー: $e');
    }
  }
}
