import 'dart:convert';

import 'package:http/http.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  static Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        data: decodedJson,
      );
    } else {
      return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
    }
  }
}
